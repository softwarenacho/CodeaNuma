class Proposal < ActiveRecord::Base

  after_initialize :default_url

  # validates :twitter_handle, uniqueness: true

  def default_url
    if self.avatar == ""
      self.avatar = "luchador.png"
    end
  end

  def send_to_codea
      api_token = "54bc6608e61a68f1c6c6e4d411e63a6b"
      url = "http://localhost:3000/?api_token=#{api_token}&name=#{self.name}&avatar=#{self.avatar}&twitter_handle=#{self.twitter_handle}"
      encoded_url = URI.encode(url)
      http_request = Net::HTTP.get_response(URI.parse(encoded_url)).body
      data = ActiveSupport::JSON.decode(http_request) #.to_json
  end

end
