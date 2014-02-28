class ManagementController < ApplicationController
  include Auth
  before_action :require_admin, only: [:domain_stats]

  def index
    @site = current_agent.sites.first
    @user_present = current_agent.users.present?
  end

  def report
  end

  def domain_stats
    @agents = Agent.order(created_at: :desc).page params[:page]
  end

  private

  def require_admin
    unless current_agent.admin?
      flash[:error] = 'You must be admin to access this section'
      redirect_to management_index_url # halts request cycle
    end
  end
end
