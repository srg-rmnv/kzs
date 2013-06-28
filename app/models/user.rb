class User < ActiveRecord::Base
  attr_accessible :name, :phone, :position, :organization_id, :division, :info,
                  :email, :photo, :dob, :permit, :work_status, :right_ids
                  
  has_many :user_rights
  has_many :rights, through: :user_rights
                              
  WORK_STATUSES = [ [I18n.t('at_work'), 'at_work'], [I18n.t('ooo'), 'ooo'] ]
  
  has_attached_file :photo, :styles => { :thumb => "48x48#" }
  
  validates :name, :phone, :position, :organization_id, :division, :info,
                   :email, :photo, :dob, :permit, :work_status, :presence => true
  validates :phone, :length => { :maximum => 11 }
  
  
end