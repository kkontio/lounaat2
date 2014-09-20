class RemoveBarFenniaAddPerobaCafe < ActiveRecord::Migration
  def up
    Restaurant.create(name: 'Peroba Cafe')
    Restaurant.find_by_name('Bar Fennia').destroy

    Rake::Task['init_lunches'].invoke
  end

  def down
    Restaurant.find_by_name('Peroba Cafe').destroy

    r = Restaurant.create(name: 'Bar Fennia')
    r.parser = 'sello'
    r.url = 'http://www.sello.fi/liikkeet/ravintolat-ja-kahvilat/bar-fennia/lounaslista-viikko-<cweek>'

    Rake::Task['init_lunches'].invoke
  end
end
