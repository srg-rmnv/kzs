class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  attr_accessor :login

  attr_accessible :phone, :position, :division, :info, :dob, :permit, :phone, 
                  :work_status, :organization_id, :email, :password, :password_confirmation, 
                  :avatar, :first_name, :last_name, :username, :right_ids, :remember_me,
                  :is_staff, :is_active, :is_superuser, :date_joined, :permission_ids, :group_ids
                  
  has_many :user_permissions
  has_many :permissions, through: :user_permissions, :uniq => true
  has_many :user_groups
  has_many :groups, through: :user_groups, :uniq => true
  has_many :statement_approvers
  has_many :statements, through: :statement_approvers
  has_many :open_notices
  has_one :permit
  
  scope :superuser, -> { where(is_superuser: true) }
                              
  WORK_STATUSES = %w[at_work ooo]
  
  validates :username, :first_name, :last_name, :phone, :position,
            :division, :dob, :organization_id, :work_status, :presence => true
            
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
  
  def has_permission?(role)
    permissions.exists?(role)
  end

  
end