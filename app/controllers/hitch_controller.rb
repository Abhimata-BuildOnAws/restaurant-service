class HitchController < ApplicationController
  def create
    hitch = Hitch.create()
    hitch_order = HitchOrder.create(order_id: params[:order_id], hitch_id: hitch.id)

    render :json => { hitch: hitch }, status: 200
  end
  
  def get_all
    hitches = ::Hitch.all

    render :json => { hitches: hitches }, status: 200
  end
end