class CreateLunchItems < ActiveRecord::Migration
  def change
    create_table :lunch_items do |t|
      t.text :description
      t.integer :lunch_id

      t.timestamps
    end
  end
end
