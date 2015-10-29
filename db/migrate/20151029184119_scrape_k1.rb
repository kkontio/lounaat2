class ScrapeK1 < ActiveRecord::Migration
  def up
    r = Restaurant.find_by_name("K1")
    r.url = 'http://www.kanresta.fi/app/lunchlist/view/'
    r.save
  end

  def down
    r = Restaurant.find_by_name("K1")
    r.url = nil
    r.save
  end
end
