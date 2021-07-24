# frozen_string_literal: true

class MenuItem < ApplicationRecord
  # Relationships
  has_one_attached :image
  belongs_to :restaurant

  # Validations
  validates_uniqueness_of :name, scope: %i[restaurant_id], message: 'This item is already listed under your restaurant'
  after_save :add_to_order_service

  def add_to_order_service
    order_service_ip = ServiceDiscovery.order_service_ip
    # Public IP
    # order_service_ip = "18.139.84.70"
    url = "http://" + order_service_ip + ":3000/menu_item/create"

    headers = { "Content-Type": "application/json; charset=utf-8" }

    conn = Faraday.new(
      url: url,
      headers: headers
    )

    values = {
      "id": id,
      "restaurant_id": restaurant_id,
      "name": name,
      "price": price
    }
    
    response = conn.post do |req|
      req.body = values.to_json
    end
  end
end
