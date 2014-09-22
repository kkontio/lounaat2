class AddPerobaCafeUrl < ActiveRecord::Migration
  def up
    r = Restaurant.find_by_name('Peroba Cafe')

    unless r.nil?
      r.url = 'http://www.perobacafe.fi/index.php/lounas/'
      r.save
    end
  end

  def down
    r = Restaurant.find_by_name('Peroba Cafe')

    unless r.nil?
      r.url = nil
      r.save
    end
  end
end
