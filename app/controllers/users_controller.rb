#
class UsersController < OpenReadController
  skip_before_action :authenticate, only: [:login, :create]

  def login
    credentials = user_credentials
    if (user = User.authenticate credentials[:email],
                                 credentials[:password])
      render json: user, serializer: UserLoginSerializer, root: 'user'
    else
      head :unauthorized
    end
  end

  def create
    user = User.create(user_credentials)
    if user.valid?
      render json: user, status: :created
    else
      head :bad_request
    end
  end

  def index
    render json: User.all
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    head :bad_request
  end

  private

  def user_credentials
    params.require(:credentials)
      .permit(:email, :password, :password_confirmation)
  end
end
