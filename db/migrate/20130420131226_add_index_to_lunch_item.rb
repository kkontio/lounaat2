class AddIndexToLunchItem < ActiveRecord::Migration
  def up
    add_index :lunch_items, :lunch_id
  end

  def down
    remove_index :lunch_items, :lunch_id
  end
end
