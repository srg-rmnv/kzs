class StatementApprover < ActiveRecord::Base
  attr_accessible :accepted, :statement_id, :user_id
  belongs_to :statement
  belongs_to :user
end
