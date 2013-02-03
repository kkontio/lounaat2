class ChangeDataTypeForDescription < ActiveRecord::Migration
  def up
    change_table :lunches do |t|
      t.change :description, :text
    end
  end

  def down
    change_table :lunches do |t|
      t.change :description, :string
    end
  end
end
