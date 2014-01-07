class UpdateRetroUrl < ActiveRecord::Migration
  def up
    restaurants = {}

    restaurants['Retro'] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-retro/lounaslista-viikko-<cweek>',
                             :alias => 'retro' }

    restaurants.each do |name, details|
      r = Restaurant.find_or_create_by_name(name)
      r.url = details[:url]
      r.alias = details[:alias]
      r.save
    end
  end

  def down
  end
end
