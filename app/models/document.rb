class Document < ActiveRecord::Base
  attr_accessible :deadline, :file, :organization_id, :recipient_id, :text, :title, :user_id
  
  has_attached_file :file
end
