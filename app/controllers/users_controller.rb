class UsersController < ApplicationController

  def index
    @users = User.all.normal_users
    @admins = User.all.admins
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Usuario eliminado"
    redirect_to users_url
  end

end






