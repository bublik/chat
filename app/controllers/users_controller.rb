class UsersController < ApplicationController
  include Auth
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = current_agent.users.order('users.position ASC')
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.agent = current_agent

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: t('.created_successful') }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def sort
    params[:user].each_with_index do |id, index|
      current_agent.users.where(username: id).update_all({position: index+1})
    end
    render nothing: true
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: t('.updated_successful') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #
  ## DELETE /users/1
  ## DELETE /users/1.json
  #def destroy
  #  @user.destroy
  #  respond_to do |format|
  #    format.html { redirect_to users_url }
  #    format.json { head :no_content }
  #  end
  #end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_agent.users.where('users.username = ?', params[:id]).first
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :password, :operator_name)
  end
end
