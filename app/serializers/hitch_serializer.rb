# frozen_string_literal: true

class HitchSerializer
  include JSONAPI::Serializer

  attributes :pickup, :latitude, :longitude, :total_pollution

  # Returns a straight distance (not accounting route distance) from restaurant to the user in metres
  attribute :absolute_distance do |hitch, params|
    current_user = params[:current_user]
    hitch.distance_to(current_user.coordinates)
  end

  # Returns the route distance from restaurant to the user in metres
  attribute :travel_distance do |hitch, params|
    current_user = params[:current_user]
    @restaurant = hitch.restaurant
    @distance = get_distance(@restaurant, hitch)
  end

  # Calculates effective pollution for each customer that hitches onto this delivery
  # In grams
  attribute :effective_pollution do |hitch, _params|
    @effective_pollution = hitch.each_pollution
  end

  def self.get_distance(hitch, current_user)
    distance = OpenRoutesService.get_travel_distance('driving-car', hitch.coordinates, current_user.coordinates)
  end

  attribute :delivery_from do
    @restaurant.address
  end

  # tree point = effective_pollution - 700
  # if effective_pollution > 700, minus points
  # if < 700, plus points
  attribute :tree_point do
    (@effective_pollution - 700) * -1
  end
end
