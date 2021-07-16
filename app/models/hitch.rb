class Hitch < ApplicationRecord
  has_many :orders
  belongs_to :user
  belongs_to :restaurant

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
end
