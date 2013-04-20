class LunchItem < ActiveRecord::Base
  attr_accessible :description, :lunch_id
  belongs_to :lunch
end
