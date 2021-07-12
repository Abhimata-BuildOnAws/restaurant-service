class OrderController < ApplicationController
  require 'json'
  def create
    new_order = Order.create()
    orders = JSON.parse(request.body.read)['order']

    orders.each do |o|
      menu_item_id = o['menu_item_id']
      quantity = o['quantity']
      OrderItem.create(order_id: new_order.id, quantity: quantity, menu_item_id: menu_item_id)
    end

    render :json => { order: new_order }, status: 200
  end
end