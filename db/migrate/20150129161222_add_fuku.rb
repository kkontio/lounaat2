class AddFuku < ActiveRecord::Migration
  def up
    Restaurant.find_or_create_by_name('Fuku Supreme')
  end

  def down
    Restaurant.find_by_name('Fuku Supreme').destroy
  end
end
