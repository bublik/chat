class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]
  before_action :check_domain_origin, only: [:show]
  before_filter :set_categories, only: [:new, :edit, :update, :create]
  before_filter :grant_cross_domain

  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.all
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    # TODO check this uid on new build talk
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
    @site.user = current_user

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
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
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
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
    @site = Site.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def site_params
    params.require(:site).permit(:name, :domain, :site_category_id, :color, :side, :position, :title_online,
                                 :title_offline, :collect_stats, :show_offline, :show_offline, :auto_open, :disabled)
  end

  def grant_cross_domain
    # http://www.w3.org/TR/cors/
    response.headers["Access-Control-Allow-Origin"] = '*'
    response.headers["Access-Control-Allow-Credentials"] = 'true'
    response.headers["P3P"] = 'CP="IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT"'

    # response.headers["Access-Control-Allow-Methods"] = 'GET, POST, XMODIFY'
    #response.headers["Access-Control-Request-Method"] = 'POST'
  end

  # Этот метод будет проверять соответствие запроса конфига и request.referrer домена
  # что бы не запрашивали конфиги и не досили с других доменов
  def check_domain_origin
    if !user_signed_in? && !@site.domain.eql?(URI(request.referrer).host)
      logger.error "Domain Refferer: does't match with requested Site ID"
      logger.error "DOMAIN: #{@site.domain} | IP: #{request.remote_ip} | REFERRER: #{request.referrer}"
      return false
    end
  end
end
