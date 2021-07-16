class OrderItem < ApplicationRecord
  belongs_to :menu_items, required: false
  belongs_to :order
end
