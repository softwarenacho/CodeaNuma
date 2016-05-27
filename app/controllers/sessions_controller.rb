class SessionsController < ApplicationController
  
  skip_before_action :require_login, only: [:new, :create]
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:danger] = 'Combinación de email/password errónea.'
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if verify_old_password
      if @user.update_attributes(password_params)
        flash[:success] = "Actualización exitosa"
        redirect_to @user
      end
    else
      flash[:danger] = "La contraseña actual"
    end
  end 

  def destroy
    sign_out
    flash.now[:success] = 'Hasta luego, te estaremos esperando!"'
    redirect_to root_url  
  end

  private

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

end