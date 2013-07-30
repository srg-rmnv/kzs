class Permission < ActiveRecord::Base
  attr_accessible :description, :title
  
  has_many :user_permissions
  has_many :users, through: :user_permissions
end
