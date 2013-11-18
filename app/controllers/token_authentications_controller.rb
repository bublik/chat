class TokenAuthenticationsController < ApplicationController
  include Auth

  def create
    current_agent.reset_authentication_token!
    redirect_to request.referer.present? ? :back : edit_agent_registration_path
  end

  def destroy
    current_agent.authentication_token = nil
    current_agent.save
    redirect_to request.referer.present? ? :back : edit_agent_registration_path
  end

end
