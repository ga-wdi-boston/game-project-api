#
class GamesController < ProtectedController
  include ActionController::Live

  skip_before_action :authenticate, only: :watch
  before_action :query_string_authenticate, only: :watch

  private

  def query_string_authenticate
    token = params[:token]
    @current_user = User.find_by token: token
    head :unauthorized unless current_user
  end

  def base_query
    Game.where('player_x_id = :user or player_o_id = :user',
               user: current_user.id)
  end

  def save(game, status=:success)
    if game.save
      render json: game, status: status
    else
      render json: { errors: game.errors }, status: :bad_request
    end
  end

  # rubocop:disable Metrics/AbcSize
  def data_for_watch(json)
    data = ActiveSupport::JSON.decode json
    hash_for_json = {}
    cells = []
    if data['cells']
      before = data['cells'].first
      after = data['cells'].last
      before.zip(after).each_with_index do |p, i|
        cells <<
          { index: i, value: p.last } if p.first != p.last
      end
      hash_for_json[:cell] =
        cells.length > 1 ? cells : cells.first
    end
    hash_for_json[:over] = data['over'] if data['over']
    hash_for_json[:updatedAt] =
      data['updated_at'].last.to_datetime.to_s
    if cells.length > 1
      { errors: hash_for_json }
    else
      { game: hash_for_json }
    end
  end

  public

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def watch
    game = base_query.where(over: false).find(params[:id])
    timeout = params[:timeout] ? params[:timeout].to_i : 120
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream)
    begin
      game.listen_for_update(timeout) do |data|
        sse.write(data_for_watch data)
      end
      sse.write(timeout: 'watch timed out')
    rescue IOError, ClientDisconnected => e
      logger.info e.to_s + ': ' + Time.now.to_s
    ensure
      logger.info 'Streaming thread stopped: ' + Time.now.to_s
      sse.close
    end
    render nothing: true
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
