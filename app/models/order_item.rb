# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :menu_item
  belongs_to :order

  validate :menu_item_must_be_from_hitch_restaurant

  def menu_item_must_be_from_hitch_restaurant
    unless errors.add(:menu_item_id, 'must be from the restaurant you are tumpanging from')
    end
  end
end
