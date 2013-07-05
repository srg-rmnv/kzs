class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.integer :user_id
      t.integer :organization_id
      t.string :recipient
      t.string :deadline
      t.string :text
      t.attachment :file

      t.timestamps
    end
  end
end
