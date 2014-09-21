# encoding: UTF-8
desc "Initializes lunches for a week forward. Weekends excluded."
task :init_lunches => :environment do
  puts "Init lunches started #{Time.now.to_s}"

  dates = []
  d = Date.today

  for i in 0..6
    d = d + i.days
    unless d.saturday? || d.sunday?
      dates << d
    end
  end

  restaurants = Restaurant.all

  restaurants.each do |r|
    dates.each do |d|
      Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => r.id, :date => d)
    end
  end
end
