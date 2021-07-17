# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def current_user(params)
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
      # Change this to raise an error eventually
      # render json: e
      puts e
    end

    case user_type
    when 'restaurant'
      user = Restaurant.find(user_id)
    when 'user'
      user = User.find(user_id)
    end
    # Remove test_user when we have frontend/sign in logic working
    user || test_user
  end

   # Remove test_user when we have frontend/sign in logic working
  def test_user
    User.find_by(email: 'pbeebsandj@gmail.com')
  end
end
