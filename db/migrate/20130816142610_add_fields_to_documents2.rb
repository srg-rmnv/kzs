class AddFieldsToDocuments2 < ActiveRecord::Migration
  def change
    add_column :documents, :confidential, :boolean, :default => false
    add_column :documents, :executor_id, :integer
    add_attachment :documents, :attachment
  end
end
