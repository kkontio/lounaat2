class CreateLunches < ActiveRecord::Migration
  def change
    create_table :lunches do |t|
      t.integer :restaurant_id
      t.string :description
      t.date :date

      t.timestamps
    end
  end
end
