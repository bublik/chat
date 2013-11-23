class Api::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate, only: [:online, :offline]
  before_filter :set_username

  def online
    User.mark_online(set_username)
    render nothing: true
  end

  def offline
    User.mark_offline(set_username)
    render nothing: true
  end

  def state
    render text: User.get_state(set_username)
  end

  protected

  def set_username
    params.permit(:user)[:user]
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      (username == APP_CONFIG['api']['base_user'] && password == APP_CONFIG['api']['base_password'])
    end
  end
end
