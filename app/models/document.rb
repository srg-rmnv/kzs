class Document < ActiveRecord::Base
  attr_accessible :deadline, :file, :organization_id, :recipient_id, :text,
                  :title, :user_id, :approver_id, :opened, :for_approve, :deleted, :archived, :callback
  
  scope :sent, -> { where(sent: true) }
  scope :not_approved, -> { where(approved: false) }
  scope :approved, -> { where(approved: true) }
  scope :draft, -> { where(sent: false) }
  scope :unopened, -> { where(opened: false) }
  scope :not_deleted, -> { where(deleted: false) }
  scope :not_archived, -> { where(archived: false) }
  scope :deleted, -> { where(deleted: true) }
  scope :archived, -> { where(archived: true) }
  scope :callback, -> { where(callback: true) }
  
  
  
  has_attached_file :file
end