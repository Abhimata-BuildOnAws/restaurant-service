# frozen_string_literal: true

class RestaurantSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :latitude, :longitude, :street, :state, :country, :contact_no, :stripe_id

  attribute :absolute_distance do |restaurant, params|
    restaurant.distance_to(params[:coordinates])
  end
end
