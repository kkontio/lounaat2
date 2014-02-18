class RenameAliasColumn < ActiveRecord::Migration
  def change
    rename_column :restaurants, :alias, :scraper
  end
end
