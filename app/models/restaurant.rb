# frozen_string_literal: true

class Restaurant < ApplicationRecord
  # Relationships
  has_many :menu_items
  geocoded_by :address

  # Validations
  validates :email, uniqueness: true
  validates_uniqueness_of :name, scope: %i[street], message: 'This restaurant is already listed under the same address'

  after_validation :geocode
  after_save :add_to_order_service

  def address
    if state == country
      [street, country].compact.join(', ')
    else
      [street, state, country].compact.join(', ')
    end
  end

  def add_to_order_service
    order_service_ip = ServiceDiscovery.order_service_ip
    # Public IP
    # order_service_ip = "18.139.84.70"
    url = "http://" + order_service_ip + ":3000/restaurant/create"

    headers = { "Content-Type": "application/json; charset=utf-8" }

    conn = Faraday.new(
      url: url,
      headers: headers
    )

    values = {
      "id": id,
      "name": name,
      "street": street,
      "stripe_id": stripe_id,
      "state": state,
      "country": country,
      "latitude": latitude,
      "longitude": longitude
    }
    
    response = conn.post do |req|
      req.body = values.to_json
    end
  end
end
