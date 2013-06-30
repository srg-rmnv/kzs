class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :phone, :position, :organization_id, :division, :info,
                  :avatar, :dob, :permit, :work_status, :right_ids,
                  :email, :password, :password_confirmation, :remember_me
                  
  has_many :user_rights
  has_many :rights, through: :user_rights
                              
  WORK_STATUSES = [ [I18n.t('at_work'), 'at_work'], [I18n.t('ooo'), 'ooo'] ]
  
  validates :name, :phone, :position, :organization_id, :division,
                   :email, :dob, :permit, :work_status, :presence => true
  validates :phone, :length => { :maximum => 11 }
  
  has_attached_file :avatar, :styles => { :small => "48x48#", :large => "100x100#" } 

  
end