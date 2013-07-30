class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  attr_accessor :login

  attr_accessible :phone, :position, :division, :info, :dob, :permit, :phone, 
                  :work_status, :organization_id, :email, :password, :password_confirmation, 
                  :avatar, :first_name, :last_name, :username, :right_ids, :remember_me,
                  :is_staff, :is_active, :is_superuser, :date_joined, :permission_ids
                  
  has_many :user_permissions
  has_many :permissions, through: :user_permissions
  has_many :open_notices
  
  scope :superuser, -> { where(is_superuser: true) }
                              
  WORK_STATUSES = [ [I18n.t('at_work'), 'at_work'], [I18n.t('ooo'), 'ooo'] ]
  
  validates :position, :organization_id, :division,
            :email, :work_status, :presence => true
            
  validates :username, uniqueness: true
  
  has_attached_file :avatar, :styles => { :small => "48x48#", :large => "100x100#" } 
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
  def email_required?
    false
  end

  def email_changed?
    false
  end
  
  def first_name_with_last_name
      "#{last_name} #{first_name}"
  end
  
  def self.superusers_from_orgranization(organization_id)
        superuser.where(:organization_id => organization_id)
  end

  
end