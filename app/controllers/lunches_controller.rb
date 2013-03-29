class LunchesController < ApplicationController
  before_filter :initialize_votes

  def index
    @lunches_by_date = Lunch.lunches_by_date
  end

  def vote
    if session[:votes].add? params[:id]
      Lunch.find(params[:id]).add_vote
    end
    redirect_to root_path
  end

  private
  def initialize_votes
    session[:votes] ||= Set.new
  end
end
