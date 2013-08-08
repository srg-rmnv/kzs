class AddWritToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :document_type, :string
    add_column :documents, :with_comments, :boolean, :default => false
    add_column :documents, :executed, :boolean, :default => false
  end
end
