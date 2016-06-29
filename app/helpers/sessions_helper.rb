module SessionsHelper

  def require_login
    unless signed_in?
      store_location
      flash[:danger] = "Inicia sesión"
      redirect_to signin_url # halts request cycle
    end
  end

  def only_admin_user
    flash[:danger] = "No tienes los permisos necesarios para acceder a esta sección" unless current_user.admin?
    redirect_to(signin_url) unless current_user.admin?
  end

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user_admin?
    if signed_in?
      current_user.admin?
    else
      false
    end
  end

  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    session.destroy
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

end