class OrderController < ApplicationController
  require 'json'

  # Create new order
  def create
    new_order = Order.create(user: current_user(nil))
    orders = JSON.parse(request.body.read)['order']
    hitch_id = JSON.parse(request.body.read)['hitch_id']

    new_order.update(hitch_id: hitch_id)
    total_price = 0

    orders.each do |o|
      menu_item = MenuItem.find(o['menu_item_id'])
      quantity = o['quantity']
      oi = OrderItem.create(order_id: new_order.id, quantity: quantity, menu_item_id: menu_item.id)

      raise Errors::OrderItemCreationError unless oi.errors.empty?
      
      total_price += quantity * menu_item.price
    end

    new_order.update(total_price: total_price)

    pollution = 100
    if new_order.hitch_id.present?
      pollution = new_order.hitch.each_pollution
    end

    render :json => { order: new_order, pollution: pollution}, status: 200
  end
end