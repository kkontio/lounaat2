class UpdateBarFennia < ActiveRecord::Migration
  def up
    restaurants = {}
    
    restaurants['Bar Fennia'] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/bar-fennia/lounaslista-viikko-<cweek>',
                                  :alias => 'bar_fennia' }

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
