class RemoveDescriptionFromLunch < ActiveRecord::Migration
  def up
    remove_column :lunches, :description
  end

  def down
    add_column :lunches, :description, :text
  end
end
