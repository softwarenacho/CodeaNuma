class TwitterUsersController < ApplicationController

  def twitter_create
    twitter =  request.env['omniauth.auth']
    @user = User.find_by(twitter_handle: "#{twitter.info.nickname}")
    if @user == nil
	  	@user = User.new
	  	@user.name = twitter.info.name
	  	@user.email = twitter.info.email
	  	@user.twitter_handle = twitter.info.nickname
	  	@user.avatar = twitter.info.image.gsub!("_normal", "")
	  	@user.oauth_token = twitter.credentials.token
	  	@user.oauth_secret = twitter.credentials.secret
	  end
    session[:user_id] = @user.id
  	if @user.save
  		flash[:success] = "Conectado con Twitter exitosamente"
      sign_in @user
      redirect_to user_path(@user)
    else
    	flash[:danger] = "Hubo un error con tu inicio de sesión"
      redirect_to root_path
    end
  end

  def search_users
    @search_word = params[:twitter][:search]
    @users = CLIENT.user_search(@search_word) 
  end

end
