class Jan2015RetroUrlUpdate < ActiveRecord::Migration
  def up
    r = Restaurant.find_by_name('Retro')
    r.url = 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-retro/lounaslista-viikko-<cweek>'
    r.save
  end

  def down
    r = Restaurant.find_by_name('Retro')
    r.url = 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-retro/lounaslista-viikko-<cweek>-0'
    r.save
  end
end
