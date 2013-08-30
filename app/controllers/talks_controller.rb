class TalksController < ApplicationController
  before_action :set_talk, only: [:show, :edit, :update, :destroy]
  before_action :set_site
  before_filter :grant_cross_domain, only: [:create]

  # GET /talks
  # GET /talks.json
  def index
    @talks = Talk.all
  end

  # GET /talks/1
  # GET /talks/1.json
  def show
  end

  # GET /talks/new
  def new
    @talk = Talk.new
  end

  # GET /talks/1/edit
  def edit
  end

  # POST /talks
  # POST /talks.json
  def create
    unless @talk = Talk.where(id: talk_params[:id]).first
      logger.debug('Talk not found and will be created new')
      @talk = Talk.new(talk_params.merge(
                           remote_ip: request.remote_ip,
                           referer: request.referer,
                           user_agent: request.user_agent
                       ))
    else
      logger.debug('Talk found!')
    end

    @talk.valid?
    logger.debug(@talk.errors.full_messages.inspect)
    respond_to do |format|
      if @talk.save
        message = Message.new(message_params.merge(talk_id: @talk.id)) # heck assign id if change reference without embeded messages
        @talk.messages << message
        publish_message(site_talks_path(@site), message.to_publish)
        logger.debug( message.to_publish)
        format.html { redirect_to @talk, notice: 'Talk was successfully created.' }
        format.json { render nothing: true,  status: :created } #render action: 'show', status: :created, location: @talk }
        #format.json { render text: "cfrm.append_message({content: 'werwerwer'}",  status: :created } #render action: 'show', status: :created, location: @talk }
      else
        format.html { render action: 'new' }
        format.json { render json: @talk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /talks/1
  # PATCH/PUT /talks/1.json
  def update
    respond_to do |format|
      if @talk.update(talk_params)
        format.html { redirect_to @talk, notice: 'Talk was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @talk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /talks/1
  # DELETE /talks/1.json
  def destroy
    @talk.destroy
    respond_to do |format|
      format.html { redirect_to talks_url }
      format.json { head :no_content }
    end
  end

  private

  # set default channel as public
  # this data will be pushed to client thought websocket
  # and will be used on subscribe defined callback
  def publish_message(channel = '/messages/new', data = {})
    PrivatePub.publish_to(channel, {message: data})
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_talk
    @talk = Talk.find(params[:id])
  end

  def set_site
    @site = Site.find(params[:site_id])
  end

  def message_params
    params.require(:message).permit(:content, :locale, :time_at)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def talk_params
    params.require(:talk).permit(:id, :site_id, :user_sid)
  end

  def grant_cross_domain
    # http://www.w3.org/TR/cors/
    response.headers["Access-Control-Allow-Origin"] = '*'
    response.headers["Access-Control-Allow-Credentials"] = 'true'
    response.headers["P3P"] = 'CP="IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT"'

    # response.headers["Access-Control-Allow-Methods"] = 'GET, POST, XMODIFY'
    #response.headers["Access-Control-Request-Method"] = 'POST'
  end
end
