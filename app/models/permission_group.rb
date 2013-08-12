class PermissionGroup < ActiveRecord::Base
  attr_accessible :group_id, :permission_id
  belongs_to :group
  belongs_to :permission
end
