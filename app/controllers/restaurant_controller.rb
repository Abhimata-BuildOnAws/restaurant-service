# frozen_string_literal: true

class RestaurantController < ApplicationController
  # Creating and Updating
  
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
    menu_item = MenuItem.create(restaurant: restaurant, name: params[:name], description: params[:description], price: params[:price], image: params[:image])
    serializer = MenuItemSerializer.new(menu_item)
    render json: serializer.serializable_hash
  end

  

  def edit_restaurant
    restaurant = Restaurant.find(params[:restaurant_id])
    restaurant.update(restaurant_params)
    raise StandardError, restaurant.errors.full_messages unless restaurant.errors.empty?
    render json: restaurant
  end

  def edit_menu_item
    menu_item = MenuItem.find(params[:menu_item_id])
    menu_item.update(menu_item_params)
    raise StandardError, menu_item.errors.full_messages unless menu_item.errors.empty?
    serializer = MenuItemSerializer.new(menu_item)
    render json: serializer.serializable_hash
  end

  def add_picture_for_menu_item
    menu_item = MenuItem.find(params[:menu_item_id])
    File.open(params[:image])
    menu_item.image.attach(params[:image])
    serializer = MenuItemSerializer.new(menu_item)
    render json: serializer.serializable_hash
  end

  # Viewing

  def browse
    restaurant = ::Restaurant.near(params[:coordinates], 20)
    serializer = RestaurantSerializer.new(restaurant, { params: {coordinates: params['coordinates']} })
    render json: serializer.serializable_hash
  end

  def get_restaurant
    restaurant = Restaurant.find(params[:restaurant_id])
    serializer = RestaurantSerializer.new(restaurant, { params: {coordinates: params['coordinates']} })
    render json: serializer.serializable_hash
  end

  def get_restaurant_menu
    restaurant = Restaurant.find(params[:restaurant_id])
    serializer = MenuItemSerializer.new(restaurant.menu_items)
    render json: serializer.serializable_hash
  end

  def get_menu_items
    menu_items = MenuItem.find(params[:menu_item_id])
    serializer = MenuItemSerializer.new(menu_items)
    render json: serializer.serializable_hash
  end

  # private

  def menu_item_params
    params.permit(:name, :description, :price, :image).select { |k,v| !v.blank?}
  end

  def restaurant_params
    params.permit(:email, :name, :street, :state, :country, :contact_no).select { |k,v| !v.blank?}
  end
end
