class UsersProposals < ActiveRecord::Migration
  def change
  	create_table :users_proposals do |t|
      t.string   :proposal_id
      t.string   :user_id
    end
  end
end
