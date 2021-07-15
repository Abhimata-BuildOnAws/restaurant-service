class RestaurantController < ApplicationController
  def browse
    restaurant = ::Restaurant.all
    
    serializer = RestaurantSerializer.new(restaurant, {params: {current_user: current_user}})
    render json: serializer.serializable_hash
  end


  private
  def current_user
    begin
      resp = Cognito.get_user(params[:access_token])

      #Initialise variables
      user_type = user_id = ''
      
      # Determine user_type and id of currently logged in user
      resp.user_attributes.each do |t|
        if t['name'] == 'sub'
          user_id = t['value']
        elsif t['name'] == 'custom:User_Type'
          user_type = t['value']
        end
      end
    rescue => e
      render json: e
    end

    case user_type
    when 'restaurant'
      user = Restaurant.find(user_id)
    when 'user'
      user = User.find(user_id)
    end
    user
  end
end