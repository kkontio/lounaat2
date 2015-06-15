# encoding: UTF-8
class RestaurantsController < ApplicationController
  def lunch_of_the_day
    r = Restaurant.where("lower(restaurants.name) like ?", "%#{params[:restaurant].downcase}%").first

    not_found if r.nil?

    lunch_items = LunchItem.joins(:lunch => :restaurant)
      .where("restaurants.id = ?", r.id)
      .where("lunches.date = ?", Date.today)

    response = construct_response r, lunch_items unless r.nil?

    respond_to do |format|
      format.html { render :text => response}
      format.text { render :text => response}
    end
  end

  private

  def construct_response(restaurant, lunch_items)
      response = ":fork_and_knife: #{restaurant.name} tarjoaa tänään lounaaksi:"

      unless lunch_items.empty?
        lunch_items.each do |li|
          response += "\n#{li.description}"
        end
      else
        response += "\nEi mitään erityistä. :neutral_face:"
      end

      return response
  end
end
