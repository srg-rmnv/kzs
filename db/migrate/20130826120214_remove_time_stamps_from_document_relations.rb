class RemoveTimeStampsFromDocumentRelations < ActiveRecord::Migration
  def up
    remove_column(:document_relations, :created_at)
    remove_column(:document_relations, :updated_at)
  end

  def down
    add_column(:document_relations, :created_at, :datetime)
    add_column(:document_relations, :updated_at, :datetime)
  end
end
