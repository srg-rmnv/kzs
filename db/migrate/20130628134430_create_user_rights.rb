class CreateUserRights < ActiveRecord::Migration
  def change
    create_table :user_rights do |t|
      t.integer :user_id
      t.integer :right_id

      t.timestamps
    end
  end
end
