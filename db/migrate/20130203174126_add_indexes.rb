class AddIndexes < ActiveRecord::Migration
  def up
    add_index :restaurants, :name
    add_index :lunches, :date
    add_index :lunches, [:restaurant_id, :date]
  end

  def down
    remove_index :restaurants, :name
    remove_index :lunches, :date
    remove_index :lunches, [:restaurant_id, :date]
  end
end
