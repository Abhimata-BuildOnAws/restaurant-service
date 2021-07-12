class MenuItem < ApplicationRecord
  # Relationships
  belongs_to :restaurant
  has_many :order_items
  has_many :orders, through: :order_items

  # Validations
  validates_uniqueness_of :name, scope: %i[restaurant_id], message: 'This item is already listed under your restaurant'
end
