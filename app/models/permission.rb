class Permission < ActiveRecord::Base
  attr_accessible :description, :title
  
  has_many :user_permissions
  has_many :users, through: :user_permissions
  
  has_many :permission_groups
  has_many :groups, through: :permission_groups
end
