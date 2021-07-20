# frozen_string_literal: true

class Restaurant < ApplicationRecord
  # Relationships
  has_many :menu_items
  geocoded_by :address

  # Validations
  validates :email, uniqueness: true
  validates_uniqueness_of :name, scope: %i[street], message: 'This restaurant is already listed under the same address'

  after_validation :geocode

  def address
    if state == country
      [street, country].compact.join(', ')
    else
      [street, state, country].compact.join(', ')
    end
  end
end
