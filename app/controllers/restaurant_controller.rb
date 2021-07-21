# frozen_string_literal: true

class RestaurantController < ApplicationController
  def create_restaurant
    restaurant = Restaurant.create(email: params[:email], name: params[:name],
                                   street: params[:address], state: params[:state],
                                   country: params[:country], contact_no: params[:contact_no])
    raise Errors::RestaurantCreationError unless restaurant.errors.empty?

    # Stripe account creation
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    account = Stripe::Account.create({
                                       type: 'express'
                                     })
    restaurant.update(stripe_id: account.id)
    # Create on Order Service as well

    account_links = Stripe::AccountLink.create({
                                                 account: account.id,
                                                 refresh_url: 'https://localhost:3000',
                                                 return_url: 'https://localhost:3000',
                                                 type: 'account_onboarding'
                                               })
    # render json: { stripe_url: account_links.url }, status: 200
    redirect_to account_links.url
  end

  def add_menu_item_to_restaurant
    restaurant = Restaurant.find(params[:restaurant_id])
    MenuItem.create(restaurant: restaurant, name: params[:name], description: params[:description], price: params[:price])
  end

  def browse
    restaurant = ::Restaurant.all

    serializer = RestaurantSerializer.new(restaurant, { params: {coordinates: params['coordinates']} })
    render json: serializer.serializable_hash
  end

  def menu
    restaurant = Restaurant.find(params[:restaurant_id])
    render json: restaurant.menu_items
  end
end
