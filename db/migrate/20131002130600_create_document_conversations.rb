class CreateDocumentConversations < ActiveRecord::Migration
  def change
    create_table :document_conversations do |t|

      t.timestamps
    end
  end
end
