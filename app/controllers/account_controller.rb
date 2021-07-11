# frozen_string_literal: true

class AccountController < ApplicationController
  def signup
    user = User.create(email: params[:email],
                       name: params[:name],
                       password: params[:password],
                       address: params[:address])
    if user.errors.empty?
      render json: { message: 'Successful Sign Up' }, status: 200
    else
      render json: { error: 'There is an error signing up' }, status: 401 
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      render json: { message: 'Successful Log In' }, status: 200
    else
      render json: { message: 'Invalid credentials' }, status: 401
    end
  end
end
