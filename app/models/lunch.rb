class Lunch < ActiveRecord::Base
  attr_accessible :date, :restaurant_id, :votes
  validates :date, :uniqueness => { :scope => :restaurant_id }
  belongs_to :restaurant
  has_many :lunch_items, :dependent => :destroy, :order => 'id ASC'

  # Returns lunches for today and the next 6 days
  def self.week_of_lunches
    lunches = includes(:restaurant, :lunch_items).where("date >= ? AND date <= ?", Date.today, Date.today + 6.days).order('date')

    with_lunch_items = {}
    without_lunch_items = {}

    lunches.each do |l|
      with_lunch_items[l.date] ||= []
      without_lunch_items[l.date] ||= []

      if l.lunch_items.empty?
        without_lunch_items[l.date] << l
      else
        with_lunch_items[l.date] << l
      end
    end

    with_lunch_items.values.each { |v| v.sort! { |a,b| a.restaurant.name <=> b.restaurant.name } }
    without_lunch_items.values.each { |v| v.sort! { |a,b| a.restaurant.name <=> b.restaurant.name } }

    return with_lunch_items, without_lunch_items
  end

  def add_vote
    self.votes = self.votes + 1
    self.save
  end
end
