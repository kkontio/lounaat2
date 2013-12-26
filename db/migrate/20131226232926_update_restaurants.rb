class UpdateRestaurants < ActiveRecord::Migration
  def up
    restaurants = {}

    restaurants['Café Buffo'] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/cafe-buffo/lounaslista-viikko-<cweek>',
                                  :alias => 'buffo' }
    restaurants["Chico's"] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/chicos/lounaslista-viikko-<cweek>',
                               :alias => 'chicos' }
    restaurants['Ravintola Fennia'] =
        { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-fennia/lounaslista-viikko-<cweek>',
          :alias => 'ravintola_fennia' }
    restaurants['Bar Fennia'] = { :url => nil,
                                  :alias => 'bar_fennia' }
    restaurants['Base'] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-base/lounaslista-viikko-<cweek>',
                            :alias => 'base' }
    restaurants['GLO Grill Kitchen'] =
        { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/glo-grill-kitchen/lounaslista-viikko-<cweek>',
          :alias => 'glo' }
    restaurants['Retro'] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-retro/lounaslista-viikko-<cweek>-0',
                             :alias => 'retro' }
    restaurants['Lokki'] = { :url => 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/il-gabbiano/lounaslista-viikko-<cweek>',
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
  end

  def down
  end
end
