class AddBurgerKing < ActiveRecord::Migration
  def up
    Restaurant.find_or_create_by_name("Burger King")
  end

  def down
    Restaurant.find_or_create_by_name("Burger King")
  end
end
