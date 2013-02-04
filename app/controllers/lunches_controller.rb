class LunchesController < ApplicationController
  def index
    @lunches = Lunch.where("date >= ?", Date.today)
  end
end
