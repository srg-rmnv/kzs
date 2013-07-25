class AddPreparedToDocuments < ActiveRecord::Migration
  def up
    add_column :documents, :prepared, :boolean, :default => false
    
    Document.all.each do |document|
      document.prepared = false
      document.save
    end
  end
  
  def down
    remove_column :documents, :prepared
  end
end
