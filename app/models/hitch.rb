class Hitch < ApplicationRecord
  has_many :orders

  # Calculate pollution each customer emitted if they were to hitch on a deliver
  # WIP : change 100 to pollution index
  def each_pollution
    100 / self.hitch_orders.count
  end
end
