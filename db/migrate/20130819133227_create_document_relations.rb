class CreateDocumentRelations < ActiveRecord::Migration
  def change
    create_table :document_relations do |t|
      t.integer :document_id
      t.integer :relational_document_id

      t.timestamps
    end
  end
end
