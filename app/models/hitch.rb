# frozen_string_literal: true

class Hitch < ApplicationRecord
  has_many :orders
  belongs_to :user
  belongs_to :restaurant

  geocoded_by :pickup

  after_create :calculate_pollution
  after_validation :geocode

  # Calculate pollution each customer emitted if they were to hitch on a deliver
  # WIP : change 100 to pollution index
  def each_pollution
    if orders.count.zero?
      total_pollution
    else
      total_pollution / orders.count
    end
  end

  def coordinates
    [longitude, latitude]
  end

  private

  def calculate_pollution
    travel_distance = calculate_travel_distance('driving-car')
    # WIP : Average grams of carbon emitted per kilometer is 250g
    pollution = travel_distance * 250 / 1000
    update(total_pollution: pollution)
  end

  def calculate_travel_distance(mode_of_transport)
    OpenRoutesService.get_travel_distance(mode_of_transport, restaurant.coordinates, coordinates)
  end
end
