class AddSentToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :sent, :boolean, :default => false
  end
end
