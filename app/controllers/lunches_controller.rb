class LunchesController < ApplicationController
  def index
    lunch_days = Lunch.select(:date).uniq.where("date >= ?", Date.today).order("date")
    h = {}
    lunch_days.each do |d|
      h[d.date] = Lunch.includes(:restaurant).where("date = ?", d.date).order("restaurant_id")
    end

    h.each_pair do |k,v|
      puts k.to_s
      v.each do |v|
        puts v.restaurant.name
      end
    end


    @lunches = Lunch.includes(:restaurant).where("date >= ?", Date.today).order("date")
  end
end
