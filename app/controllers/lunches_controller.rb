# encoding: UTF-8
class LunchesController < ApplicationController
  before_filter :initialize_votes

  def handle_unverified_request
    reset_session
    if request.xhr?
      flash[:error] = "Istuntosi oli vanhentunut. Yritä uudelleen."
      render :js => "window.location = '/'"
    end
  end

  def index
    @lunches_by_date = Lunch.lunches_by_date
  end

  def vote
    @lunch = Lunch.find(params[:id])

    if session[:votes].add? params[:id]
      @lunch.add_vote
    end

    respond_to do |format|
      format.html { redirect_to root}
      format.js
    end
  end

  private

  def initialize_votes
    session[:votes] ||= Set.new
  end
end
