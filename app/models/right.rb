class Right < ActiveRecord::Base
  attr_accessible :title
  
  has_many :user_rights
  has_many :users, through: :user_rights
end
