#
class GamesController < ProtectedController
  include ActionController::Live

  skip_before_action :authenticate, only: :watch
  before_action :query_string_authenticate, only: :watch

  private

  def query_string_authenticate
    token = params[:token]
    @current_user = AUTH_BLOCK.call(token)
    head :unauthorized unless current_user
  end

  def base_query
    Game.where('player_x_id = :user or player_o_id = :user',
               user: current_user.id)
  end

  def save(game, status = :ok)
    if game.save
      render json: game, status: status
    else
      render json: { errors: game.errors }, status: :bad_request
    end
  end

  HEARTBEAT = 30

  def start_heartbeat
    Thread.new do
      count = 0
      until @queue.closed?
        @queue.push heartbeat: count += 1
        sleep HEARTBEAT
      end
    end
  end

  def handle_notify
    @game.listen_for_update(@timeout) do |_event, data|
      @queue.push data
    end
    @queue.push timeout: 'watch timed out'
    @queue.close
  end

  def start_notify
    Thread.new do
      handle_notify
    end
  end

  public

  def watch
    @queue = Queue.new
    @game = base_query.where(over: false).find(params[:id])
    @timeout = params[:timeout] ? params[:timeout].to_i : 120
    heartbeat = start_heartbeat
    notify = start_notify
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream)
    begin
      until @queue.closed?
        event = @queue.pop
        sse.write event
      end
    rescue IOError, ClientDisconnected => e
      logger.info e.to_s + ': ' + Time.now.to_s
    ensure
      logger.info 'Streaming thread stopped: ' + Time.now.to_s
      sse.close
    end
    notify.join
    heartbeat.join
  end

  def index
    render json:
      if (over = params[:over])
        base_query.where(over: over)
      else
        base_query
      end
  end

  def show
    render json: base_query.find(params[:id])
  end

  def create
    game = Game.new(player_x: current_user)
    save game, :created
  end

  # two main possibilities:
  # 1 - player 'o' joining a game
  # 2 - either player updating the game state

  # rubocop:disable Metrics/AbcSize
  def update
    if (updates = params[:game]) && !updates.empty?
      game = base_query.find(params[:id])
      if (cell = updates[:cell])
        game.cells[cell[:index].to_i] = cell[:value]
      end
      if (over = updates[:over])
        game.over = over
      end
      save game
    else # join the game
      game = Game.find(params[:id])
      if game.player_o || game.player_x == current_user
        head :bad_request
      else
        game.player_o = current_user
        save game
      end
    end
  end
end
