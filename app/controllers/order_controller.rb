class OrderController < ApplicationController
  require 'json'
  def create
    new_order = Order.create()
    orders = JSON.parse(request.body.read)['order']

    total_price = 0

    orders.each do |o|
      menu_item = find_menu_item(o['menu_item_id'])
      quantity = o['quantity']
      OrderItem.create(order_id: new_order.id, quantity: quantity, menu_item_id: menu_item.id)
      total_price += quantity * menu_item.price
    end

    new_order.update(total_price: total_price)

    render :json => { order: new_order}, status: 200
  end

  private 
  def find_menu_item(menu_item_id)
    MenuItem.find_by(id: menu_item_id)
  end
end