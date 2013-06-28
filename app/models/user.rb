class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :phone, :position, :organization_id, :division, :info,
                  :photo, :dob, :permit, :work_status, :right_ids,
                  :email, :password, :password_confirmation, :remember_me
                  
  has_many :user_rights
  has_many :rights, through: :user_rights
                              
  WORK_STATUSES = [ [I18n.t('at_work'), 'at_work'], [I18n.t('ooo'), 'ooo'] ]
  
  has_attached_file :photo, :styles => { :thumb => "48x48#" }
  
  validates :name, :phone, :position, :organization_id, :division, :info,
                   :email, :photo, :dob, :permit, :work_status, :presence => true
  validates :phone, :length => { :maximum => 11 }
  
  
end