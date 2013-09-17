class ManagementController < ApplicationController
  include Auth

  def index
    @site = current_agent.sites.first
    @user = current_agent.user
  end

  def report
  end
end
