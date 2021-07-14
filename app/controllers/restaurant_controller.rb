class RestaurantController < ApplicationController
  def browse
    restaurants = ::Restaurant.all
    render json: { restaurants: restaurants }, status: 200
  end
end