class AddVotesToLunches < ActiveRecord::Migration
  def change
    add_column :lunches, :votes, :integer, :default => 0
  end
end
