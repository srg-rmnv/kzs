class Document < ActiveRecord::Base
  attr_accessible :deadline, :file, :organization_id, :recipient_id, :text,
                  :title, :user_id, :approver_id, :opened, :for_approve, :deleted, :archived, :callback
  
  scope :sent, -> { where(sent: true) }
  scope :not_approved, -> { where(approved: false) }
  scope :approved, -> { where(approved: true) }
  scope :draft, -> { where(sent: false) }
  scope :unopened, -> { where(opened: false) }
  
  
  
  has_attached_file :file
end