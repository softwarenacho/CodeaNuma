class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :email
      t.string   :phone
      t.string   :password_digest
      t.boolean  :admin, :default => false
      t.string   :remember_token      
      t.string   :api_token      

      t.timestamps
    end
  end
end
