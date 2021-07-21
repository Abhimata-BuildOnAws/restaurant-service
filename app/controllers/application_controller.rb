# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def current_user(params)
    Restaurant.find(params[:user_id])
  end
end
