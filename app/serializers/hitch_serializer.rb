class HitchSerializer
  include JSONAPI::Serializer

  attributes :pickup, :latitude, :longitude

  # Returns a straight distance (not accounting route distance) from restaurant to the user in metres
  attribute :absolute_distance do |hitch, params|
    current_user = params[:current_user]
    hitch.distance_to(current_user.coordinates)
  end

  # Returns the route distance from restaurant to the user in metres 
  attribute :travel_distance do |hitch, params|
    current_user = params[:current_user]
    @distance = get_distance(hitch, current_user)
  end

  # Returns the total grams of carbon emitted for the whole delivery in grams
  attribute :total_pollution do |hitch, params|
    current_user = params[:current_user]
    # WIP : Average grams of carbon emitted per kilometer is 250g
    @total_pollution = @distance * 250 / 1000
  end  


  # Calculates effective pollution for each customer that hitches onto this delivery
  # In grams
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