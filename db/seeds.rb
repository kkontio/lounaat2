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

restaurants['Café Buffo'] = { :url => 'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/caf-buffo/showlunch',
                              :alias => 'buffo' }
restaurants["Chico's"] = { :url => 'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/chico-s/showlunch',
                           :alias => 'chicos' }
restaurants['Ravintola Fennia'] =
    { :url => 'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ravintola-fennia/showlunch',
      :alias => 'ravintola_fennia' }
restaurants['Bar Fennia'] = { :url => 'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/bar-fennia/showlunch',
                              :alias => 'bar_fennia' }
restaurants['Base'] = { :url => 'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ravintola-base/showlunch',
                        :alias => 'base' }
restaurants['GLO Grill Kitchen'] =
    { :url => 'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/glo-grill-kitchen/showlunch',
      :alias => 'glo' }
restaurants['Retro'] = { :url => 'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ravintola-retro/showlunch',
                         :alias => 'retro' }
restaurants['Lokki'] = { :url => 'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ilgabbiano/showlunch',
                         :alias => 'lokki' }
restaurants['Kotipizza'] = { :alias => 'kotipizza'}
restaurants["Robert's Coffee"] = { :alias => 'roberts'}
restaurants['Lime Leaf'] = { :alias => 'lime'}
restaurants['Classic Pizza'] = { :alias => 'classic'}
restaurants['Mandarin Palace'] = { :alias => 'mandarin_palace'}
restaurants['Kultainen Tai'] = { :alias => 'kultainen_tai'}
restaurants['Curry Palace'] = { :alias => 'curry_palace'}
restaurants['Hesburger'] = { :alias => 'hesburger'}
restaurants['Rax'] = { :alias => 'rax'}
restaurants['Subway'] = { :alias => 'subway'}
restaurants['Picnic'] = { :alias => 'picnic'}
restaurants['Persian Ravintola'] = { :alias => 'persian_ravintola'}

# Add them to the db
restaurants.each do |name, details|
  r = Restaurant.find_or_create_by_name(name)
  r.url = details[:url]
  r.alias = details[:alias]
  r.save
end

# Initialize lunch list
Lunch.init_lunches

# Do a scrape
Rake::Task['scraper:scrape_lunches'].invoke
