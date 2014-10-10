# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :api_group_subscription do
    group nil
    path "MyString"
    tag "MyString"
  end
end
