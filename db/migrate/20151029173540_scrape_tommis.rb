class ScrapeTommis < ActiveRecord::Migration
  def up
    r = Restaurant.find_by_name("Tommi's kitchen")
    r.url = 'http://www.tommiskitchen.fi/'
    r.save
  end

  def down
    r = Restaurant.find_by_name("Tommi's kitchen")
    r.url = nil
    r.save
  end
end
