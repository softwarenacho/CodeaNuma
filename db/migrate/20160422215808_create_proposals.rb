class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :name
      t.string :avatar
      t.string :twitter_handle
      t.integer :counter, default: 1

      t.timestamps null: false
    end
  end
end
