class CreateOpenNotices < ActiveRecord::Migration
  def change
    create_table :open_notices do |t|
      t.integer :document_id
      t.integer :user_id

      t.timestamps
    end
  end
end
