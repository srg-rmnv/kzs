class Group < ActiveRecord::Base
  attr_accessible :title, :permission_ids
  
  has_many :permission_groups
  has_many :permissions, through: :permission_groups
  has_many :user_groups
  has_many :users, through: :user_groups
end
