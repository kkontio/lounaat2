class LunchItem < ActiveRecord::Base
  attr_accessible :description, :lunch_id
  validates :description, :uniqueness => { :scope => :lunch_id }
  belongs_to :lunch
end
