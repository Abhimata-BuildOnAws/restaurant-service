class Order < ApplicationRecord
  has_many :order_items
  has_many :menu_items, through: :order_items

  has_one :hitch_order
  has_one :hitch, through: :hitch_order
end
