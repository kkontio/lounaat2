# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lunch do
    restaurant_id 1
    description "MyString"
    date "2012-11-09"
  end
end
