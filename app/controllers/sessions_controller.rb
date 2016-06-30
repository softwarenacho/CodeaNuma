class SessionsController < ApplicationController
  
  def destroy
    session.clear
    flash.now[:success] = 'Hasta luego, te estaremos esperando!"'
    redirect_to root_url  
  end

end