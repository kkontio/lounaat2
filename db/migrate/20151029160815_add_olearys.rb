class AddOlearys < ActiveRecord::Migration
  def up
    r = Restaurant.find_or_create_by_name("O'Learys")
    r.url = 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/olearys/lounaslista-viikko-<cweek>'
    r.save
  end

  def down
    Restaurant.find_by_name("O'Learys").destroy
  end
end
