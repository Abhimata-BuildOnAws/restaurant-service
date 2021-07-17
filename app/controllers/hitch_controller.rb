class HitchController < ApplicationController

  # Create a new Tumpang
  def create
    submit_time = DateTime.iso8601(params[:submit_time])
    hitch = Hitch.create(
      submit_time: params[:submit_time], 
      pickup: params[:pickup],
      user: current_user(nil),
      restaurant_id: params[:restaurant_id])

    serializer = HitchSerializer.new(hitch, {params: {current_user: current_user(params)}})

    render json: serializer.serializable_hash
  end
  
  # Get all hitches that are active
  def get_all
    hitches = ::Hitch.all

    serializer = HitchSerializer.new(hitches, {params: {current_user: current_user(params)}})
    render json: serializer.serializable_hash
  end

  private

  # Retrieve current location of user
  def current_location
    ip = request.remote_ip
    results = Geocoder.search(ip)
    results.first.address
  end
end