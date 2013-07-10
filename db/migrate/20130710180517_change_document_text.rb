class ChangeDocumentText < ActiveRecord::Migration
  def change
    change_column :documents, :text, :text, :limit => nil
  end
end
