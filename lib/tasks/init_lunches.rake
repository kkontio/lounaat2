# encoding: UTF-8
desc "Fetch lunch info from Sello's lunch list"
task :init_lunches => :environment do
  puts "Init lunches started #{Time.now.to_s}"
  Lunch.init_lunches
end