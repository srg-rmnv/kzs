class ChangeDocuments < ActiveRecord::Migration
  def up
    remove_column :documents, :recipient
    add_column :documents, :recipient_id, :integer
  end

  def down
    remove_column :documents, :recipient
    add_column :documents, :recipient, :string
  end
end
