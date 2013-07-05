class CreateApproveUsers < ActiveRecord::Migration
  def change
    create_table :approve_users do |t|
      t.integer :document_id
      t.integer :user_id

      t.timestamps
    end
  end
end
