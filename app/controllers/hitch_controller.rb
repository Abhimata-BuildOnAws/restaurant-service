class HitchController < ApplicationController

  # Create a new Tumpang
  def create
    hitch = Hitch.create()

    add_order_to_hitch(hitch, params[:order_id])

    render :json => { hitch: hitch }, status: 200
  end
  
  # Get all hitches that are active
  def get_all
    hitches = ::Hitch.all

    render :json => { hitches: hitches }, status: 200
  end

  # Add order to an existing tumpang
  def add_order
    hitch = Hitch.find_by(id: params[:hitch_id])

    add_order_to_hitch(hitch, params[:order_id])
    
    render :json => { hitch: hitch }, status: 200
  end

  private
  def add_order_to_hitch(hitch, order_id)
    order = Order.find_by(id: order_id)

    order.update(hitch_id: hitch.id)
  end
end