class Lunch < ActiveRecord::Base
  attr_accessible :date, :description, :restaurant_id, :votes
  validates :date, :uniqueness => { :scope => :restaurant_id }
  belongs_to :restaurant

  def self.lunches_by_date()
    lunches = includes(:restaurant).where("date >= ?", Date.today).order('date')

    l_by_d = {}

    lunches.each do |l|
      l_by_d[l.date] ||= []
      l_by_d[l.date] << l
    end

    l_by_d.values.each { |v| v.sort! { |a,b| a.restaurant.name <=> b.restaurant.name } }

    return l_by_d
  end

  def add_vote
    self.votes = self.votes + 1
    self.save
  end
end
