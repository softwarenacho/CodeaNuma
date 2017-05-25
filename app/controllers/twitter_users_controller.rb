class TwitterUsersController < ApplicationController

  def twitter_create
    twitter =  request.env['omniauth.auth']
    pp twitter
    @user = User.find_or_create_by(twitter_handle: "#{twitter.info.nickname}") do |user|
	  	user.name = twitter.info.name
	  	user.email = twitter.info.email
	  	user.twitter_handle = twitter.info.nickname
	  	user.avatar = twitter.info.image.gsub!("_normal", "")
	  	user.oauth_token = twitter.credentials.token
	  	user.oauth_secret = twitter.credentials.secret
	  end
    p @user
    session[:user_id] = @user.id
		flash[:success] = "Conectado con Twitter exitosamente"
    redirect_to user_path(@user)
  end

  def search_users
    @search_word = params[:twitter][:search]
    @users = CLIENT.user_search(@search_word)
  end

end
