class AddAliasToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :alias, :string
  end
end
