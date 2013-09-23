class ArchiveJidPrefsController < ApplicationController
  include Auth
  before_action :set_archive_jid_pref, only: [:show, :edit, :update, :destroy]

  # GET /archive_jid_prefs
  # GET /archive_jid_prefs.json
  def index
    @archive_jid_prefs = ArchiveJidPref.all
  end

  # GET /archive_jid_prefs/1
  # GET /archive_jid_prefs/1.json
  def show
  end

  # GET /archive_jid_prefs/new
  def new
    @archive_jid_pref = ArchiveJidPref.new
  end

  # GET /archive_jid_prefs/1/edit
  def edit
  end

  # POST /archive_jid_prefs
  # POST /archive_jid_prefs.json
  def create
    @archive_jid_pref = ArchiveJidPref.new(archive_jid_pref_params)

    respond_to do |format|
      if @archive_jid_pref.save
        format.html { redirect_to @archive_jid_pref, notice: 'Archive jid pref was successfully created.' }
        format.json { render action: 'show', status: :created, location: @archive_jid_pref }
      else
        format.html { render action: 'new' }
        format.json { render json: @archive_jid_pref.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /archive_jid_prefs/1
  # PATCH/PUT /archive_jid_prefs/1.json
  def update
    respond_to do |format|
      if @archive_jid_pref.update(archive_jid_pref_params)
        format.html { redirect_to @archive_jid_pref, notice: 'Archive jid pref was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @archive_jid_pref.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /archive_jid_prefs/1
  # DELETE /archive_jid_prefs/1.json
  def destroy
    @archive_jid_pref.destroy
    respond_to do |format|
      format.html { redirect_to archive_jid_prefs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_archive_jid_pref
      @archive_jid_pref = ArchiveJidPref.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def archive_jid_pref_params
      params.require(:archive_jid_pref).permit(:with_user, :with_resource, :save, :expire, :otr)
    end
end
