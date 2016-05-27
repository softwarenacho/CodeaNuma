class User < ActiveRecord::Base

  before_create :generate_api_token
  before_save :downcase_names
  after_initialize :titleize_names
  before_create :create_remember_token
  before_save { self.email = email.downcase }


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, :if => :password

  scope :admins, proc { where(admin: true) }
  scope :normal_users, proc { where(admin: false) }

  has_secure_password

  def name
    read_attribute(:name).try(:titleize)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
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

    def downcase_names
      self.send("#{:name}=", self.send(:name).downcase) if self.send(:name)
    end

    def titleize_names
      self.send("#{:name}=", self.send(:name).titleize) if self.send(:name)
    end

end