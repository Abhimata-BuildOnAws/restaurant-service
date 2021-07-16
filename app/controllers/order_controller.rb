class OrderController < ApplicationController
  require 'json'

  # Create new order
  def create
    new_order = Order.create()
    orders = JSON.parse(request.body.read)['order']

    total_price = 0

    orders.each do |o|
      menu_item = MenuItem.find(o['menu_item_id'])
      quantity = o['quantity']
      oi = OrderItem.create(order_id: new_order.id, quantity: quantity, menu_item_id: menu_item.id)

      total_price += quantity * menu_item.price
    end

    new_order.update(total_price: total_price)

    pollution = 100
    if new_order.hitch_id.present?
      pollution = new_order.hitch.each_pollution
    end

    render :json => { order: new_order, pollution: pollution}, status: 200
  end

  def directions
    resp = OpenRoutesService.get_route('cycling-regular', [8.681495,49.41461], [8.687872,49.420318])
    render json: resp
  end

  def distance
    distance = OpenRoutesService.get_travel_distance('cycling-regular', [8.681495,49.41461], [8.687872,49.420318])
    render json: { distance: distance }, status: 200
  end
end