class UpdateBaseUrl < ActiveRecord::Migration
  def up
    r = Restaurant.find_by_name('Base')
    r.url = 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-base/lounaslista-viikko-<cweek>'
    r.save
  end

  def down
    r = Restaurant.find_by_name('Base')
    r.url = 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-base/lounaslista-viikko-<cweek>-0'
    r.save
  end
end
