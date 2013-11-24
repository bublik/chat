class ManagementController < ApplicationController
  include Auth

  def index
    @site = current_agent.sites.first
    @user_present = current_agent.users.present?
  end

  def report
  end
end
