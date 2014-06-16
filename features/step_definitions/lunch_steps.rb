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

Given(/^there are no special lunch items at "(.*?)" today$/) do |restaurant|
  r = Restaurant.find_by_name(restaurant)
  l = Lunch.create!(:date => Date.today, :restaurant_id => r.id)
end

Given(/^there are lunches for the previous week and the following two weeks$/) do
  restaurants = Restaurant.all
  restaurants.each do |r|
    for i in -7..13
      Lunch.create!(:date => Date.today + i.days, :restaurant_id => r.id)
    end
  end
end

Then(/^I should see "(.*?)" on today's lunch list$/) do |text|
  find("##{Date.today.to_s}").should have_content text
end

Then(/^I should see "(.*?)" listed under "(.*?)" for today$/) do |lunch_item, restaurant|
  find("##{Date.today.to_s}").should have_content restaurant
  find("##{Date.today.to_s} .#{restaurant}").should have_content lunch_item
end

Then(/^I should see "(.*?)" before "(.*?)"$/) do |earlier_content, later_content|
  page.body.should =~ /#{earlier_content}.*#{later_content}/m
end

Then(/^I should see lunches for the coming week$/) do
  restaurants = Restaurant.all
  restaurants.each do |r|
    for i in 0..6
      find("##{(Date.today + i.days).to_s}").should have_content r.name
    end
  end
end

Then(/^I should not see lunches for yesterday$/) do
  restaurants = Restaurant.all
  restaurants.each do |r|
     page.should_not have_css("##{Date.yesterday.to_s}")
  end
end

Then(/^I should not see lunches seven days in the future$/) do
  restaurants = Restaurant.all
  restaurants.each do |r|
    page.should_not have_css("##{(Date.today + 7.days).to_s}")
  end
end

When(/^I vote for "(.*?)" for today's lunch$/) do |restaurant|
  find(".#{restaurant}").find('.restaurant_votes').find('a').click
end

Then(/^I should see vote for "(.*?)" for today$/) do |restaurant|
  find(".#{restaurant}").find('.restaurant_votes').should have_css('.fa-star')
end

