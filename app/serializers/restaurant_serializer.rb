# frozen_string_literal: true

class RestaurantSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :latitude, :longitude, :street, :state, :country, :contact_no, :stripe_id

  attribute :absolute_distance do |restaurant, params|
    current_user = params[:current_user]
    restaurant.distance_to([current_user.latitude, current_user.longitude])
  end
end
