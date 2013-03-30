class Lunch < ActiveRecord::Base
  attr_accessible :date, :description, :restaurant_id, :votes
  validates :date, :uniqueness => { :scope => :restaurant_id }
  belongs_to :restaurant

  def self.lunches_by_date
    lunches = includes(:restaurant).where("date >= ?", Date.today).order('date')

    h = {}

    lunches.each do |l|
      h[l.date] ||= []
      h[l.date] << l
    end

    h.values.each { |v| v.sort! { |a,b| a.restaurant.name <=> b.restaurant.name } }

    return h
  end

  def add_vote
    self.votes = self.votes + 1
    self.save
  end
end
