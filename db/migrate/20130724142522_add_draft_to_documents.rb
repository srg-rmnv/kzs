class AddDraftToDocuments < ActiveRecord::Migration
  def up
    add_column :documents, :draft, :boolean, :default => true
    
    Document.all.each do |document|
      document.draft = true
      document.save
    end
  end
  
  def down
    remove_column :documents, :draft
  end
end
