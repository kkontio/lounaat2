class LunchesController < ApplicationController
  def index
    @lunches_by_date = Lunch.lunches_by_date
  end
end
