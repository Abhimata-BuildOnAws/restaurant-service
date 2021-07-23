# frozen_string_literal: true

class MenuItem < ApplicationRecord
  # Relationships
  has_one_attached :image
  belongs_to :restaurant

  # Validations
  validates_uniqueness_of :name, scope: %i[restaurant_id], message: 'This item is already listed under your restaurant'
end
