class OrderController < ApplicationController
  require 'json'

  # Create new order
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

    pollution = 100
    if new_order.hitch_id.present?
      pollution = new_order.hitch.each_pollution
    end

    render :json => { order: new_order, pollution: pollution}, status: 200
  end

  def directions
    resp = OpenRoutesService.get_route('cycling-regular', 0)
    render json: resp
  end

  private 
  def find_menu_item(menu_item_id)
    MenuItem.find_by(id: menu_item_id)
  end
end