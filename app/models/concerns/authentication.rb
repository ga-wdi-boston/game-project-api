#
module Authentication
  extend ActiveSupport::Concern

  #
  module ClassMethods
    def authenticate(email, password)
      user = find_by email: email
      user if user && user.authenticate(password)
    end

    def by_token(token)
      find_by token: token
    end
  end

  def authenticate_with_new_token(password)
    authenticate_without_new_token(password) && new_token
  end

  included do
    has_secure_password
    before_create :set_token
    after_find :fix_up_token
    validates :email, uniqueness: true
    alias_method_chain :authenticate, :new_token
  end

  private

  # FIXME: Validate that token doesn't exist? (improbable)
  def set_token
    self.token = SecureRandom.hex(16)
  end

  # unconditionally create and set a new token
  def new_token
    update_columns(token: set_token, updated_at: Time.current)
  end

  # expire old token
  def fix_up_token
    # FIXME: token age should be configurable
    new_token if updated_at < 7.day.ago
  end
end
