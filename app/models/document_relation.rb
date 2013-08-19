class DocumentRelation < ActiveRecord::Base
  attr_accessible :current_document_id, :relational_document_id
  belongs_to :document
end
