class ChangeApprovedColumn < ActiveRecord::Migration
  def up
    remove_column :documents, :approved
    add_column :documents, :approved, :boolean, :default => false
  end

  def down
    remove_column :documents, :approved
    add_column :documents, :approved, :boolean, :default => false
  end
end
