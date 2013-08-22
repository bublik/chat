class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_filter :authenticate_user!
  layout :enable_layout

  private
  def enable_layout
    user_signed_in? ? 'management' : 'portal'
  end

end
