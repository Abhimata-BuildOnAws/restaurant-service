# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def current_user(_params)
    begin
      resp = Cognito.get_user(request.headers)

      # Initialise variables
      user_type = user_id = ''

      # Determine user_type and id of currently logged in user
      resp.user_attributes.each do |t|
        case t['name']
        when 'sub'
          user_id = t['value']
        when 'custom:User_Type'
          user_type = t['value']
        end
      end
    rescue StandardError => e
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
    user
  end
end
