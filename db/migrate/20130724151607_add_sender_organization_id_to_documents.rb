class AddSenderOrganizationIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :sender_organization_id, :integer
  end
end
