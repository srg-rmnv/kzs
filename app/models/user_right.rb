class UserRight < ActiveRecord::Base
  attr_accessible :right_id, :user_id
  belongs_to :user
  belongs_to :right
end
