Given(/^the following restaurants exist:$/) do |restaurants_table|
  restaurants_table.hashes.each do |restaurant|
    Restaurant.create!(restaurant)
  end
end

Given(/^lunches are available for today$/) do
  restaurants = Restaurant.all
  restaurants.each do |r|
    Lunch.create!(:date => Date.today, :restaurant_id => r.id)
  end
end

Given(/^I am on the home page$/) do
  visit root_path
end

Given(/^there's "(.*?)" served for lunch at "(.*?)" today$/) do |lunch_item, restaurant|
  r = Restaurant.find_by_name(restaurant)
  l = Lunch.create!(:date => Date.today, :restaurant_id => r.id)
  li = LunchItem.create!(:description => lunch_item, :lunch_id => l.id)
end

Then(/^I should see "(.*?)" on today's lunch list$/) do |text|
  find("##{Date.today.to_s}").should have_content text
end


Then(/^I should see "(.*?)" listed under "(.*?)" for today$/) do |lunch_item, restaurant|
  find("##{Date.today.to_s}").should have_content restaurant
  find("##{Date.today.to_s} .#{restaurant}").should have_content lunch_item
end
