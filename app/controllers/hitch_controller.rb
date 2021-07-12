class HitchController < ApplicationController
  def create
    hitch = Hitch.create()
    order = Order.find_by(id: params[:order_id])

    hitch_order = HitchOrder.create(order_id: order.id, hitch_id: hitch.id)

    render :json => { hitch: hitch }, status: 200
  end
  
  def get_all
    hitches = ::Hitch.all

    render :json => { hitches: hitches }, status: 200
  end

  def add_order
    hitch = Hitch.find_by(id: params[:hitch_id])
    order = Order.find_by(id: params[:order_id])

    hitch_order = HitchOrder.create(order_id: params[:order_id], hitch_id: hitch.id)

    render :json => { hitch: hitch }, status: 200
  end
end