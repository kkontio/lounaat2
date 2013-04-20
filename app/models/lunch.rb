class Lunch < ActiveRecord::Base
  attr_accessible :date, :restaurant_id, :votes
  validates :date, :uniqueness => { :scope => :restaurant_id }
  belongs_to :restaurant
  has_many :lunch_items, :dependent => :destroy

  # Returns lunches for today and the next 6 days
  def self.week_of_lunches
    lunches = includes(:restaurant).where("date >= ? AND date <= ?", Date.today, Date.today + 6.days).order('date')

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

  # Initializes lunches for a week forward. Weekends excluded.
  def self.init_lunches
    dates = []

    for i in 0..6
      d = Date.today + i.days
      unless d.saturday? || d.sunday?
        dates << d
      end
    end

    restaurants = Restaurant.all

    restaurants.each do |r|
      dates.each do |d|
        l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => r.id, :date => d)
        l.save
      end
    end
  end

  def add_vote
    self.votes = self.votes + 1
    self.save
  end
end
