class SiteFeedbacksController < ApplicationController
  include Auth
  skip_before_filter :authenticate_agent!, :only => [:create]
  skip_before_filter :signup_master, :only => [:create]

  before_action :set_site_feedback, only: [:show, :edit, :update, :destroy]
  before_filter :set_site, only: [:index, :create]
  before_filter :grant_cross_domain, only: [:create]

  # GET /site_feedbacks
  # GET /site_feedbacks.json
  def index
    @site_feedbacks = @site.site_feedbacks.newest.page(params[:page])
  end

  def list
    @site_feedbacks = SiteFeedback.newest.where(site_id: current_agent.site_ids).page(params[:page])
    respond_to do |format|
      format.html { render action: 'index'}
    end
  end

  # GET /site_feedbacks/1
  # GET /site_feedbacks/1.json
  def show
  end

  # POST /site_feedbacks
  # POST /site_feedbacks.json
  def create
    @site_feedback = SiteFeedback.new(site_feedback_params)
    @site_feedback.site = @site
    @site_feedback.remote_ip = request.remote_ip
    @site_feedback.user_agent = request.user_agent
    @site_feedback.referer = request.referer

    respond_to do |format|
      if @site_feedback.save
        Notification.feedback(@site_feedback).deliver
        format.html { redirect_to @site_feedback, notice: t('.flash_created') }
        format.json { render text: {message: t('.flash_created')}.to_json, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @site_feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_feedbacks/1
  # DELETE /site_feedbacks/1.json
  def destroy
    @site_feedback.destroy
    respond_to do |format|
      format.html { redirect_to site_feedbacks_url }
      format.json { head :no_content }
    end
  end

  private
  def set_site
    @site = Site.find_by_uuid(params[:site_id])
    #logger.debug @site
    unless @site
      render :nothing => true, :status => 404
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_site_feedback
    @site_feedback = SiteFeedback.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def site_feedback_params
    params.require(:site_feedback).permit(:username, :email, :phone, :message, :site_id)
  end

end
