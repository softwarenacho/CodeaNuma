class CreateUserProposals < ActiveRecord::Migration
  def change
    create_table :user_proposals do |t|
      t.string :proposal_id
      t.string :user_id

      t.timestamps null: false
    end
  end
end
