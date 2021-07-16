class OrderItem < ApplicationRecord
  belongs_to :menu_items, optional: false
  belongs_to :order
end
