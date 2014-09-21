# encoding: UTF-8
desc "Initializes lunches for a week forward. Weekends excluded."
task :init_lunches => :environment do
  puts "Init lunches started #{Time.now.to_s}"
  Lunch.init_lunches
end
