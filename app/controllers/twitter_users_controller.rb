class TwitterUsersController < ApplicationController


  def search_users
    @search_word = params[:twitter][:search]
    @users = CLIENT.user_search(@search_word) 
  end

end
