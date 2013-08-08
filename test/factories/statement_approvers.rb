# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :statement_approver do
    user_id 1
    statement_id 1
    accepted false
  end
end
