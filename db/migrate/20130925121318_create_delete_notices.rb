class CreateDeleteNotices < ActiveRecord::Migration
  def change
    create_table :delete_notices do |t|
      t.integer :user_id
      t.integer :document_id

      t.timestamps
    end
  end
end
