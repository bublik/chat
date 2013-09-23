class ArchiveMessagesController < ApplicationController
  include Auth
  before_action :set_archive_message, only: [:show, :edit, :update, :destroy]

  # GET /archive_messages
  # GET /archive_messages.json
  def index
    @collection = current_agent.archive_collections.where('archive_collections.id' => params[:archive_collection_id]).first
    @archive_messages = @collection.archive_messages.all
  end

  # GET /archive_messages/1
  # GET /archive_messages/1.json
  def show
  end

  ## GET /archive_messages/new
  #def new
  #  @archive_message = ArchiveMessage.new
  #end

  ## GET /archive_messages/1/edit
  #def edit
  #end
  #
  ## POST /archive_messages
  ## POST /archive_messages.json
  #def create
  #  @archive_message = ArchiveMessage.new(archive_message_params)
  #
  #  respond_to do |format|
  #    if @archive_message.save
  #      format.html { redirect_to @archive_message, notice: 'Archive message was successfully created.' }
  #      format.json { render action: 'show', status: :created, location: @archive_message }
  #    else
  #      format.html { render action: 'new' }
  #      format.json { render json: @archive_message.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## PATCH/PUT /archive_messages/1
  ## PATCH/PUT /archive_messages/1.json
  #def update
  #  respond_to do |format|
  #    if @archive_message.update(archive_message_params)
  #      format.html { redirect_to @archive_message, notice: 'Archive message was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: 'edit' }
  #      format.json { render json: @archive_message.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /archive_messages/1
  # DELETE /archive_messages/1.json
  def destroy
    @archive_message.destroy
    respond_to do |format|
      format.html { redirect_to archive_messages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_archive_message
      @archive_message = ArchiveMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def archive_message_params
      params.require(:archive_message).permit(:utc, :dir, :body, :name)
    end
end
