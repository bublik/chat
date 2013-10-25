class ArchiveMessagesController < ApplicationController
  include Auth
  before_action :set_archive_message, only: [:show, :edit, :update, :destroy]

  # GET /archive_messages
  # GET /archive_messages.json
  def index
    @collection = current_agent.archive_collections.where('archive_collections.id' => params[:archive_collection_id]).first
    @location = @collection.get_location
    @archive_messages = @collection.archive_messages.all
  end

  # GET /archive_messages/1
  # GET /archive_messages/1.json
  def show
  end

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
