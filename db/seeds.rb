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
                              :parser => 'sello' }
restaurants["Chico's"] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/chicos/lounaslista-viikko-<cweek>',
                           :parser => 'sello' }
restaurants['Ravintola Fennia'] =
    { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-fennia/lounaslista-viikko-<cweek>',
      :parser => 'sello' }
restaurants['Bar Fennia'] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/bar-fennia/lounaslista-viikko-<cweek>',
                              :parser => 'sello' }
restaurants['Base'] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-base/lounaslista-viikko-<cweek>',
                        :parser => 'sello' }
restaurants['GLO Grill Kitchen'] =
    { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/glo-grill-kitchen/lounaslista-viikko-<cweek>',
      :parser => 'sello' }
restaurants['Retro'] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-retro/lounaslista-viikko-<cweek>',
                         :parser => 'sello' }
restaurants['Lokki'] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/il-gabbiano/lounaslista-viikko-<cweek>',
                         :parser => 'sello' }
restaurants['Kotipizza'] = { :parser => 'sello'}
restaurants["Robert's Coffee"] = { :parser => 'sello'}
restaurants['Lime Leaf'] = { :parser => 'sello'}
restaurants['Classic Pizza'] = { :parser => 'sello'}
restaurants['Mandarin Palace'] = { :parser => 'sello'}
restaurants['Kultainen Tai'] = { :parser => 'sello'}
restaurants['Curry Palace'] = { :parser => 'sello'}
restaurants['Hesburger'] = { :parser => 'sello'}
restaurants['Rax'] = { :parser => 'sello'}
restaurants['Subway'] = { :parser => 'sello'}
restaurants['Picnic'] = { :parser => 'sello'}
restaurants['Persian Ravintola'] = { :parser => 'sello'}

# Add them to the db
restaurants.each do |name, details|
  r = Restaurant.find_or_create_by_name(name)
  r.url = details[:url]
  r.parser = details[:parser]
  r.save
end

# Initialize lunch list
Lunch.init_lunches

# Do a scrape
Rake::Task['scraper:scrape_lunches'].invoke
