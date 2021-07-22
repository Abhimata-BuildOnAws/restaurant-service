# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  
  def health_check
    render json: { message: 'Restaurant Service is healthy' }, status:200
  end

  def current_user(params)
    Restaurant.find(params[:user_id])
  end
end
