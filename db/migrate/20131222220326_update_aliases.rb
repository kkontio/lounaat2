class UpdateAliases < ActiveRecord::Migration
  def up
    restaurants = {}
    restaurants['Café Buffo'] = {:url => 'http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/caf-buffo/showlunch',
                                 :alias => 'buffo'}
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

    restaurants.each do |name, details|
      r = Restaurant.find_by_name(name)
      unless r.nil?
        r.alias = details[:alias]
        r.save
      end
    end
  end

  def down
    Restaurant.all.each do |restaurant|
      r.alias = nil
      r.save
    end
  end
end
