# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create our restaurants
restaurants = {}

restaurants['Café Buffo'] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/cafe-buffo/lounaslista-viikko-<cweek>',
                              :scraper => 'sello' }
restaurants["Chico's"] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/chicos/lounaslista-viikko-<cweek>',
                           :scraper => 'sello' }
restaurants['Ravintola Fennia'] =
    { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-fennia/lounaslista-viikko-<cweek>',
      :scraper => 'sello' }
restaurants['Bar Fennia'] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/bar-fennia/lounaslista-viikko-<cweek>',
                              :scraper => 'sello' }
restaurants['Base'] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-base/lounaslista-viikko-<cweek>',
                        :scraper => 'sello' }
restaurants['GLO Grill Kitchen'] =
    { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/glo-grill-kitchen/lounaslista-viikko-<cweek>',
      :scraper => 'sello' }
restaurants['Retro'] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-retro/lounaslista-viikko-<cweek>',
                         :scraper => 'sello' }
restaurants['Lokki'] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/il-gabbiano/lounaslista-viikko-<cweek>',
                         :scraper => 'sello' }
restaurants['Kotipizza'] = { :scraper => 'sello'}
restaurants["Robert's Coffee"] = { :scraper => 'sello'}
restaurants['Lime Leaf'] = { :scraper => 'sello'}
restaurants['Classic Pizza'] = { :scraper => 'sello'}
restaurants['Mandarin Palace'] = { :scraper => 'sello'}
restaurants['Kultainen Tai'] = { :scraper => 'sello'}
restaurants['Curry Palace'] = { :scraper => 'sello'}
restaurants['Hesburger'] = { :scraper => 'sello'}
restaurants['Rax'] = { :scraper => 'sello'}
restaurants['Subway'] = { :scraper => 'sello'}
restaurants['Picnic'] = { :scraper => 'sello'}
restaurants['Persian Ravintola'] = { :scraper => 'sello'}

# Add them to the db
restaurants.each do |name, details|
  r = Restaurant.find_or_create_by_name(name)
  r.url = details[:url]
  r.scraper = details[:scraper]
  r.save
end

# Initialize lunch list
Lunch.init_lunches

# Do a scrape
Rake::Task['scraper:scrape_lunches'].invoke
