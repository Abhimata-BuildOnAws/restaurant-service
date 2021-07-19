# frozen_string_literal: true

class RestaurantController < ApplicationController
  def browse
    restaurant = ::Restaurant.all

    serializer = RestaurantSerializer.new(restaurant, { params: { current_user: current_user(params) } })
    render json: serializer.serializable_hash
  end
end
