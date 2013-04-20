# encoding: UTF-8
desc "Initialize lunch list"
task :init_lunches => :environment do
  puts "Init lunches started #{Time.now.to_s}"
  Lunch.init_lunches
end