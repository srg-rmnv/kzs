class CreateStatementApprovers < ActiveRecord::Migration
  def change
    create_table :statement_approvers do |t|
      t.integer :user_id
      t.integer :statement_id
      t.boolean :accepted

      t.timestamps
    end
  end
end
