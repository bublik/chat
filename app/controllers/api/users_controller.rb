class Api::UsersController < ApplicationController
  before_filter :authenticate

  def online
    logger.info('ONLINE')
    logger.info(params)
    User.mark_online(params[:username])
    render nothing: true
  end

  def offline
    logger.info('OFFLINE')
    logger.info(params)
    User.mark_offline(params[:username])
    render nothing: true
  end

  def state
    render text: User.get_state(params[:username])
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == APP_CONFIG['api']['base_user'] && password == APP_CONFIG['api']['base_password']
    end
  end
end
