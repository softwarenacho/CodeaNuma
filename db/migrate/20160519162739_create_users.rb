class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :email
      t.boolean  :admin, :default => false
      t.string   :remember_token      
      t.string   :api_token 
      t.string   :twitter_handle
      t.string   :avatar
      t.string   :oauth_token
      t.string   :oauth_secret
      t.timestamps
    end
  end
end
