class RemoveParserFromRestaurant < ActiveRecord::Migration
  def up
    remove_column :restaurants, :parser
  end

  def down
    add_column :restaurants, :parser, :string
  end
end
