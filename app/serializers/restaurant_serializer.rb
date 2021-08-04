# frozen_string_literal: true

class RestaurantSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :latitude, :longitude, :street, :state, :country, :contact_no, :stripe_id

  attribute :absolute_distance do |r, params|
    r.distance_to(params[:coordinates])
  end

  attribute :tree_points do |r, params|
    coordinates = JSON.parse(params[:coordinates])
    user_latitude = coordinates[0]
    user_longitude = coordinates[1]
    travel_distance = r.calculate_travel_distance('driving-car', [user_longitude, user_latitude])
    pollution = travel_distance * 250 / 1000
    ((pollution - 700) * -1).to_i
  end
end
