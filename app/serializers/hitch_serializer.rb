class HitchSerializer
  include JSONAPI::Serializer

  attributes :pickup, :absolute_distance, :latitude, :longitude

  attribute :absolute_distance do |hitch, params|
    current_user = params[:current_user]
    hitch.distance_to(current_user.coordinates)
  end

  attribute :travel_distance do |hitch, params|
    current_user = params[:current_user]
    @distance = get_distance(hitch, current_user)
  end

  attribute :total_pollution do |hitch, params|
    current_user = params[:current_user]
    @total_pollution = @distance * 250 / 1000
  end  

  attribute :effective_pollution do |hitch, params|
    order_count = hitch.orders.count
    if order_count == 0
      @total_pollution
    else
      @total_pollution / hitch.orders.count
    end
  end

  def self.get_distance(hitch, current_user)
    distance = OpenRoutesService.get_travel_distance('driving-car', hitch.coordinates, current_user.coordinates)
  end
end