class Organization < ActiveRecord::Base
  attr_accessible :title, :parent_id, :lft, :rgt, :logo,
                  :address, :phone, :mail, :director_id
  acts_as_nested_set
  
  validates :title, :logo, :address, :phone, :mail, :director_id, :presence => true
  has_attached_file :logo, :styles => { :pdf => "120x70#" } 
end