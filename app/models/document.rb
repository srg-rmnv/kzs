class Document < ActiveRecord::Base
  attr_accessible :deadline, :file, :organization_id, :recipient_id, :text,
                  :title, :user_id, :approver_id, :opened, :for_approve, :deleted, :archived, :callback, :prepared
  
  scope :draft, -> { where(draft: true) }   
  scope :prepared, -> { where(prepared: true) }    
  scope :approved, -> { where(approved: true) }
  scope :not_approved, -> { where(approved: false) }
  scope :sent, -> { where(sent: true) }
  scope :not_sent, -> { where(sent: false) }
  scope :unopened, -> { where(opened: false) }
  
  scope :deleted, -> { where(deleted: true) }
  scope :not_deleted, -> { where(deleted: false) }
  
  scope :archived, -> { where(archived: true) }
  scope :not_archived, -> { where(archived: false) }
  
  scope :callback, -> { where(callback: true) }
  
      
  
  
  has_attached_file :file
end