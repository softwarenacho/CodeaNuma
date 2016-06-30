class SessionsController < ApplicationController
  
  def destroy
    puts "Pasé por destroy"
    p session.clear
    flash.now[:success] = 'Hasta luego, te estaremos esperando!"'
    redirect_to root_url  
  end

end