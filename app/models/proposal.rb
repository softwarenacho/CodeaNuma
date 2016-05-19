class Proposal < ActiveRecord::Base

  after_initialize :default_url

  validates :twitter_handle, uniqueness: true

  def default_url
    if self.avatar == ""
      self.avatar = "luchador.png"
    end
  end

end
