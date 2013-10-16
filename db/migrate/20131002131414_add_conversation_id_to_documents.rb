class AddConversationIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :document_conversation_id, :integer
  end
end
