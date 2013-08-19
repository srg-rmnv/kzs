class CreateDocumentAttachments < ActiveRecord::Migration
  def change
    create_table :document_attachments do |t|
      t.attachment :attachment
      t.integer :document_id

      t.timestamps
    end
  end
end
