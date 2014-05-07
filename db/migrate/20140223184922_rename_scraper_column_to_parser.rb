class RenameScraperColumnToParser < ActiveRecord::Migration
  def change
    rename_column :restaurants, :scraper, :parser
  end
end
