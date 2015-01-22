class AddKathmanduAndUpdateUrls < ActiveRecord::Migration
  def up
    Restaurant.find_or_create_by_name('Kathmandu Palace')

    r = Restaurant.find_by_name('Ravintola Fennia')
    r.url = 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-fennia/lounaslista-viikko-<cweek>-0'
    r.save

    r = Restaurant.find_by_name('Base')
    r.url = 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-base/lounaslista-viikko-<cweek>-0'
    r.save

    r = Restaurant.find_by_name('Retro')
    r.url = 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-retro/lounaslista-viikko-<cweek>-0'
    r.save

    r = Restaurant.find_by_name('Lokki')
    r.url = 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/il-gabbiano/lounaslista-viikko-<cweek>-0'
    r.save
  end

  def down
    Restaurant.find_by_name('Kathmandu Palace').destroy

    r = Restaurant.find_by_name('Ravintola Fennia')
    r.url = 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-fennia/lounaslista-viikko-<cweek>'
    r.save

    r = Restaurant.find_by_name('Base')
    r.url = 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-base/lounaslista-viikko-<cweek>'
    r.save

    r = Restaurant.find_by_name('Retro')
    r.url = 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-retro/lounaslista-viikko-<cweek>'
    r.save

    r = Restaurant.find_by_name('Lokki')
    r.url = 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/il-gabbiano/lounaslista-viikko-<cweek>'
    r.save
  end
end
