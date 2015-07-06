# Everything except AuthController should inherit from this
class ProtectedController < ApplicationController
  before_action :authenticate
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  attr_reader :current_user

  # Requires http header
  # Authorization: Token token=<token>
  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      @current_user = User.find_by token: token
    end
  end

  def record_not_found
    render json: { message: 'Not Found' }, status: :not_found
  end
end
