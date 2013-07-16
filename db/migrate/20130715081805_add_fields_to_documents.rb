class AddFieldsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :opened, :boolean, :default => false
    add_column :documents, :for_approve, :boolean, :default => false
    add_column :documents, :deleted, :boolean, :default => false
    add_column :documents, :archived, :boolean, :default => false
    add_column :documents, :callback, :boolean, :default => false
  end
end
