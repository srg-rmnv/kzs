class AddApproveToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :approver_id, :integer
    add_column :documents, :approved, :boolean
  end
end
