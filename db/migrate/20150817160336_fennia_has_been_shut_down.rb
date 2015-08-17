class FenniaHasBeenShutDown < ActiveRecord::Migration
  def up
    r = Restaurant.find_by_name("Ravintola Fennia")
    r.destroy
  end

  def down
    r = Restaurant.find_or_create_by_name("Ravintola Fennia")
    r.url = 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/ravintola-fennia/lounaslista-viikko-<cweek>-0'
    r.save
  end
end
