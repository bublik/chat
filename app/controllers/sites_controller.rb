class SitesController < ApplicationController
  include Auth
  skip_before_filter :authenticate_agent!, :only => [:show]
  skip_before_filter :signup_master, :only => [:show]

  before_action :set_site, only: [:show, :edit, :update, :destroy]
  before_filter :check_domain_origin, only: [:show]
  before_filter :grant_cross_domain, only: [:show]
  before_filter :set_categories, only: [:new, :edit, :update, :create]


  # GET /sites
  # GET /sites.json
  def index
    redirect_to(current_agent.sites.first.present? ? current_agent.sites.first : new_site_path)
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    # logger.debug @site
  end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # GET /sites/1/edit
  def edit
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)
    @site.agent = current_agent

    respond_to do |format|
      if @site.save
        format.html { redirect_to site_path(@site), notice: t('.flash_created') }
        format.json { render action: 'show', status: :created, location: @site }
      else
        format.html { render action: 'new' }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to @site, notice: t('.flash_updated') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end

  private

  def set_categories
    @sites_categories = SiteCategory.all
  end

  def set_site
    @site = Site.where(uuid: params[:id]).includes({agent: :user}).first
    unless @site
      render :nothing => true, :status => 404
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def site_params
    params.require(:site).permit(:uuid, :name, :domain, :user_prefix, :site_category_id, :color, :side, :position, :title_online,
                                 :title_offline, :collect_stats, :show_online, :show_offline, :auto_open, :btn_title,
                                 :auto_open_timeout, :offline_welcome_message, :enabled)
  end

  # Этот метод будет проверять соответствие запроса конфига и request.referrer домена
  # что бы не запрашивали конфиги и не досили с других доменов
  def check_domain_origin
    return unless request.referrer
    unless request.referrer.to_s.match(/#{@site.domain}|#{APP_CONFIG['HOST']}/)
      logger.error "Domain Refferer: does't match with requested Site ID"
      logger.error "DOMAIN: #{@site.domain} | IP: #{request.remote_ip} | REFERRER: #{request.referrer}"
      render :nothing => true, :status => 404
      return false
    end
  end
end
