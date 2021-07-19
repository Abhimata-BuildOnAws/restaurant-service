# frozen_string_literal: true

class AuthController < ApplicationController
  def sign_up    
    user = create_user(params)
    render json: user
  end

  def confirm_sign_up
    user_object = {
      USERNAME: params[:email],
      CONFIRMATION_CODE: params[:confirmation_code]
    }
    begin
      resp = Cognito.confirm_sign_up(user_object)
      render json: { message: 'User confirmed' }, status: 200
    rescue StandardError => e
      render json: e
    end
  end


  private

  # Creation of Models
  def create_restaurant(params)
    restaurant = Restaurant.create(id: params[:user_id], email: params[:email], name: params[:name],
                                   street: params[:address], state: params[:state],
                                   country: params[:country], contact_no: params[:contact_no])
    raise Errors::RestaurantCreationError unless restaurant.errors.empty?

    # Stripe account creation
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    account = Stripe::Account.create({
                                       type: 'express'
                                     })
    restaurant.update(stripe_id: account.id)

    account_links = Stripe::AccountLink.create({
                                                 account: account.id,
                                                 refresh_url: 'https://localhost:3000',
                                                 return_url: 'https://localhost:3000',
                                                 type: 'account_onboarding'
                                               })
    # render json: { stripe_url: account_links.url }, status: 200
    redirect_to account_links.url
  end

  def create_user(params)
    user = User.create(id: params[:user_id], email: params[:email],
                       name: params[:name], street: params[:address],
                       state: params[:state], country: params[:country])
    raise Errors::UserCreationError unless user.errors.empty?
    user
  end
end
