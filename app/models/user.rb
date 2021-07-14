# frozen_string_literal: true

class User < ApplicationRecord
  # Geocoding
  geocoded_by :address

  # Validations
  validates :email, uniqueness: true

  after_validation :geocode

  def address
    [street, state, country].compact.join(', ')
  end

  def coordinates
    [latitude,longitude]
  end
end
