class MenuItem < ApplicationRecord
  # Relationships
  belongs_to :restaurant

  # Validations
  validates_uniqueness_of :name, scope: %i[restaurant_id], message: 'This item is already listed under your restaurant'
end
