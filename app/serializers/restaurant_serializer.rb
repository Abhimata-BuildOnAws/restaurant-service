class RestaurantSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :latitude, :longitude #, :street, :state, :country, :contact_no, :stripe_id,
  # belongs_to :user
  # belongs_to :tumpang


  # WIP : seed data for lat and long for user and restaurant 
  attribute :absolute_distance do |restaurant, params|
    restaurant.distance_to([43.9,-98.6])
  end
end