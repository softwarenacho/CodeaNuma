# encoding: UTF-8
class PasswordResetsController < ApplicationController

  before_action :correct_user

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.authenticate(params[:user][:old_password]) || current_user.admin?
      if !params[:user][:password].blank?
        if @user.update_attributes(password_params)
          flash[:success] = "Password cambiado"
          redirect_to user_path(@user)
        else
          render 'edit'
        end
      else
        @user.errors.add(:password, "El campo contraseña no puede estar vacío") 
        render 'edit'
      end
    else
      @user.errors.add(:password, "La contraseña actual no coincide con la que has escrito.") 
      render 'edit'
    end
  end

  private
    
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end
end