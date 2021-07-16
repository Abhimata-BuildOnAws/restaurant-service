class Hitch < ApplicationRecord
  has_many :orders

  geocoded_by :pickup

  after_validation :geocode

  # Calculate pollution each customer emitted if they were to hitch on a deliver
  # WIP : change 100 to pollution index
  def each_pollution
    100 / self.orders.count
  end

  def coordinates
    [longitude, latitude]
  end

  def restaurant  
    menu_item_id = self.orders.first.order_items.first.menu_item_id
    MenuItem.find(menu_item_id).restaurant
  end
end
