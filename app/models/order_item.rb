class OrderItem < ApplicationRecord
  belongs_to :menu_items
  belongs_to :order
end
