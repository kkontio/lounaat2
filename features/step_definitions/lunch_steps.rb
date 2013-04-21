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

Then(/^I should see "(.*?)" on today's lunch list$/) do |text|
  find("##{Date.today.to_s}").should have_content text
end
