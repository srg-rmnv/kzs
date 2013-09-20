class AddFieldsToDocuments3 < ActiveRecord::Migration
  def change
    add_column :documents, :sn, :string
    add_column :documents, :date, :datetime
    add_column :documents, :version, :integer, :default => '1'
  end
end
