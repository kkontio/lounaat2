class AddK1 < ActiveRecord::Migration
  def up
    Restaurant.find_or_create_by_name("K1")
  end

  def down
    Restaurant.find_or_create_by_name("K1")
  end
end
