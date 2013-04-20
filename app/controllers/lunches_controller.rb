# encoding: UTF-8
class LunchesController < ApplicationController
  before_filter :initialize_votes

  def handle_unverified_request
    reset_session
    if request.xhr?
      flash[:error] = "Istuntosi oli vanhentunut. Yritä uudelleen."
      render :js => "window.location = '/'"
    else
      redirect_to root_path
    end
  end

  def index
    @lunches_with_lunch_items, @lunches_without_lunch_items = Lunch.week_of_lunches
  end

  def vote
    @lunch = Lunch.find(params[:id])

    if session[:votes].add? params[:id]
      @lunch.add_vote
    end

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  private

  def initialize_votes
    session[:votes] ||= Set.new
  end
end
