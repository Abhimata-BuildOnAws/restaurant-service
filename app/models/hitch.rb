class Hitch < ApplicationRecord
  has_many :hitch_orders
  has_many :orders, through: :hitch_orders
end
