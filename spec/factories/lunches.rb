# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lunch do
    restaurant
    date Date.today
  end
end
