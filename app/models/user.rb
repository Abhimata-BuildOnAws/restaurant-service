# frozen_string_literal: true

class User < ApplicationRecord
  # Relationships
  has_many :orders
  has_many :hitches
   
  # Geocoding
  geocoded_by :address

  # Validations
  validates :email, uniqueness: true

  after_validation :geocode

  def address
    if state == country
      [street, country].compact.join(', ')
    else 
      [street, state, country].compact.join(', ')
    end
  end

  def coordinates
    [longitude, latitude]
  end
end
