class DocumentAttachment < ActiveRecord::Base
  attr_accessible :attachment
  belongs_to :document
  has_attached_file :attachment
end
