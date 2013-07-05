class Document < ActiveRecord::Base
  attr_accessible :deadline, :file, :organization_id, :recipient_id, :text, :title, :user_id
  
  scope :sent, -> { where(sent: true) }
  scope :draft, -> { where(sent: false) }
  
  has_attached_file :file
end
