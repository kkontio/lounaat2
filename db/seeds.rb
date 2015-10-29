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

restaurants['Café Buffo'] = {:url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/cafe-buffo/lounaslista-viikko-<cweek>'}
restaurants["Chico's"] = {:url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/chicos/lounaslista-viikko-<cweek>'}
restaurants['Base'] = {:url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-base/lounaslista-viikko-<cweek>-0'}
restaurants['GLO Grill Kitchen'] = {:url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/glo-grill-kitchen/lounaslista-viikko-<cweek>-0'}
restaurants['Retro'] = {:url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-retro/lounaslista-viikko-<cweek>'}
restaurants['Lokki'] = {:url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/il-gabbiano/lounaslista-viikko-<cweek>-0'}
restaurants['Kotipizza'] = {}
restaurants["Robert's Coffee"] = {}
restaurants['Lime Leaf'] = {}
restaurants['Classic Pizza'] = {}
restaurants['Mandarin Palace'] = {}
restaurants['Chopsticks'] = {}
restaurants['Curry Palace'] = {}
restaurants['Hesburger'] = {}
restaurants['Rax'] = {}
restaurants['Subway'] = {}
restaurants['Picnic'] = {}
restaurants['Persian Ravintola'] = {}
restaurants['Peroba Cafe'] = {:url => 'http://www.perobacafe.fi/index.php/lounas/'}
restaurants['Kathmandu Palace'] = {}
restaurants['Fuku Supreme'] = {}
restaurants['Burger King'] = {}
restaurants["Tommi's kitchen"] = {}
restaurants["O'Learys"] = {:url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/olearys/lounaslista-viikko-<cweek>'}
restaurants['K1'] = {}

# Add them to the db
restaurants.each do |name, details|
  r = Restaurant.find_or_create_by_name(name)
  r.url = details[:url]
  r.save
end

# Initialize lunch list
Lunch.init_lunches

# Do a scrape
Rake::Task['scrape_lunches'].invoke
