class Document < ActiveRecord::Base
  attr_accessible :deadline, :file, :organization_id, :recipient_id, :text,
                  :title, :user_id, :approver_id
  
  scope :sent, -> { where(sent: true) }
  scope :approved, -> { where(approved: true) }
  scope :draft, -> { where(sent: false) }
  
  has_attached_file :file
end
