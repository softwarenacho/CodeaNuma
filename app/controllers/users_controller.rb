class UsersController < ApplicationController

  # skip_before_action :require_login, only: [:new]
  before_action :correct_user, only: [:edit, :update, :show]
  # before_action :only_admin_user, only: [:index, :destroy]


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

  def create
    @user = User.new(user_params)
    if @user.save
        flash[:success] = "Usuario creado exitosamente"
        sign_in @user
        redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
        flash[:success] = "Actualización exitosa"
        if current_user.admin?
          redirect_to users_path
        else  
          redirect_to user_path(@user)
        end
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Usuario eliminado"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email,:photo, :password, :password_confirmation )
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "No tienes los permisos necesarios para acceder a esta sección" 
        redirect_to(root_url) 
      end
    end
end






