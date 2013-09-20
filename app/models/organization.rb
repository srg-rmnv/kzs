class Organization < ActiveRecord::Base
  attr_accessible :title, :parent_id, :lft, :rgt, :logo,
                  :address, :phone, :mail, :director_id
  acts_as_nested_set
  has_attached_file :logo, :styles => { :pdf => "120x70#" } 
end