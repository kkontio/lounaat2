# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
restaurants = {}

restaurants['Café Buffo'] = 'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/caf-buffo/showlunch'
restaurants["Chico's"] = 'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/chico-s/showlunch'
restaurants['Ravintola Fennia'] =
    'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ravintola-fennia/showlunch'
restaurants['Bar Fennia'] = 'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/bar-fennia/showlunch'
restaurants['Base'] = 'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ravintola-base/showlunch'
restaurants['GLO Grill Kitchen'] =
    'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/glo-grill-kitchen/showlunch'
restaurants['Retro'] = 'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ravintola-retro/showlunch'
restaurants['Lokki'] = 'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ilgabbiano/showlunch'
restaurants['Kotipizza'] = nil
restaurants["Robert's Coffee"] = nil
restaurants['Lime Leaf'] = nil
restaurants['Classic Pizza'] = nil
restaurants['Mandarin Palace'] = nil
restaurants['Kultainen Tai'] = nil
restaurants['Curry Palace'] = nil
restaurants['Hesburger'] = nil
restaurants['Rax'] = nil
restaurants['Subway'] = nil
restaurants['Picnic'] = nil

restaurants.each do |name, url|
  r = Restaurant.find_or_create_by_name(name)
  r.url = url
  r.save
end