class Organization < ActiveRecord::Base
  attr_accessible :title, :parent_id, :lft, :rgt
  acts_as_nested_set
end
