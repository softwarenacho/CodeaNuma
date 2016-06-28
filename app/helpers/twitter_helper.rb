module TwitterHelper
	def oauth_consumer
	  raise RuntimeError, "Debes configurar una TWITTER_KEY y TWITTER_SECRET en tu yaml file y environment." unless ENV['TWITTER_KEY'] and ENV['TWITTER_SECRET']
	  @consumer ||= OAuth::Consumer.new(
	    ENV['TWITTER_KEY'],
	    ENV['TWITTER_SECRET'],
	    :site => "https://api.twitter.com"
	  )
	end

	def host_and_port
	    host_and_port = request.host
	    host_and_port << ":#{request.port}" if request.host == "localhost"
	    host_and_port
	end

	def request_token
	  unless session[:request_token]
	    session[:request_token] = oauth_consumer.get_request_token(
	      :oauth_callback => "http://#{host_and_port}/auth"
	    )
	  end
	  session[:request_token]
	end
end
