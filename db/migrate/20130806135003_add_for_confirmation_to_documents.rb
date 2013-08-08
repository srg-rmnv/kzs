class AddForConfirmationToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :for_confirmation, :boolean, :default => false
  end
end
