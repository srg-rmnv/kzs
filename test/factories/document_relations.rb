# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :document_relation do
    current_document_id 1
    relational_document_id 1
  end
end
