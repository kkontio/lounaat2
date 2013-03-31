# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
restaurants = []

restaurants << "Café Buffo"
restaurants << "Chico's"
restaurants << "Ravintola Fennia"
restaurants << "Bar Fennia"
restaurants << "Base"
restaurants << "Carlito's"
restaurants << "Retro"
restaurants << "Lokki"
restaurants << "Kotipizza"
restaurants << "Robert's Coffee"
restaurants << "Lime Leaf"
restaurants << "Classic Pizza"
restaurants << "Mandarin Palace"
restaurants << "Kultainen Tai"
restaurants << "Curry Palace"
restaurants << "Hesburger"
restaurants << "Rax"
restaurants << "Subway"
restaurants << "Picnic"

restaurants.each do |r|
  Restaurant.find_or_create_by_name(r)
end