class AddTommisKitchen < ActiveRecord::Migration
  def up
    Restaurant.find_or_create_by_name("Tommi's kitchen")
  end

  def down
    Restaurant.find_or_create_by_name("Tommi's kitchen")
  end
end
