class User < ActiveRecord::Base

  before_create :generate_api_token
  before_create :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  scope :admins, proc { where(admin: true) }
  scope :normal_users, proc { where(admin: false) }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
  end

  def tweet(tweet)
    # p client = Twitter::REST::Client.new do |config|
    #   config.consumer_key        = Rails.application.secrets.consumer_key
    #   config.consumer_secret     = Rails.application.secrets.consumer_secret
    #   config.access_token        = self.oauth_token
    #   config.access_token_secret = self.oauth_secret
    # end
    # p client.user_timeline(tweet)
  end

  private

    def generate_api_token
      begin
        self.api_token = SecureRandom.hex
      end while self.class.exists?(api_token: api_token)
    end

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
