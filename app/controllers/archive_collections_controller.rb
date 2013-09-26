class ArchiveCollectionsController < ApplicationController
  include Auth
  before_action :set_archive_collection, only: [:show, :edit, :update, :destroy]

  # GET /archive_collections
  # GET /archive_collections.json
  def index
    @archive_collections = current_agent.archive_collections.page(params[:page])
  end

  # GET /archive_collections/1
  # GET /archive_collections/1.json
  def show
  end

  def search
    @archive_collections = current_agent.archive_collections.joins(:archive_messages).where('archive_messages.body LIKE ?', "%#{params[:q]}%").uniq.page(params[:page])
    respond_to do |format|
      format.html { render action: 'index' }
    end
  end

  ## GET /archive_collections/new
  #def new
  #  @archive_collection = ArchiveCollection.new
  #end
  #
  ## GET /archive_collections/1/edit
  #def edit
  #end
  #
  ## POST /archive_collections
  ## POST /archive_collections.json
  #def create
  #  @archive_collection = ArchiveCollection.new(archive_collection_params)
  #
  #  respond_to do |format|
  #    if @archive_collection.save
  #      format.html { redirect_to @archive_collection, notice: 'Archive collection was successfully created.' }
  #      format.json { render action: 'show', status: :created, location: @archive_collection }
  #    else
  #      format.html { render action: 'new' }
  #      format.json { render json: @archive_collection.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  #
  ## PATCH/PUT /archive_collections/1
  ## PATCH/PUT /archive_collections/1.json
  #def update
  #  respond_to do |format|
  #    if @archive_collection.update(archive_collection_params)
  #      format.html { redirect_to @archive_collection, notice: 'Archive collection was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: 'edit' }
  #      format.json { render json: @archive_collection.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /archive_collections/1
  # DELETE /archive_collections/1.json
  def destroy
    @archive_collection.destroy
    respond_to do |format|
      format.html { redirect_to archive_collections_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_archive_collection
    @archive_collection = current_agent.archive_collections.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def archive_collection_params
    params.require(:archive_collection).permit(:us, :with_user, :utc, :change_by, :change_utc)
  end
end
