class Lunch < ActiveRecord::Base
  attr_accessible :date, :description, :restaurant_id
  validates :date, :uniqueness => { :scope => :restaurant_id }
  belongs_to :restaurant
end
