class RenameTaiToChopsticks < ActiveRecord::Migration
  def up
    r = Restaurant.find_by_name('Kultainen Tai')
    r.name = 'Chopsticks'
    r.save
  end

  def down
    r = Restaurant.find_by_name('Chopsticks')
    r.name = 'Kultainen Tai'
    r.save
  end
end
