# frozen_string_literal: true

Rails.application.routes.draw do
  # Health
  get '/restaurant/health_check', to: 'application#health_check'

  # Creating and Updating
  post '/restaurant/create', to: 'restaurant#create_restaurant'
  post '/restaurant/add_menu', to: 'restaurant#add_menu_item_to_restaurant'
  post '/restaurant/add_picture_for_menu_item', to: 'restaurant#add_picture_for_menu_item'

  post '/restaurant/browse', to: 'restaurant#browse'
  post '/restaurant/get_restaurant', to: 'restaurant#get_restaurant'
  post '/restaurant/menu', to: 'restaurant#get_restaurant_menu'
  post '/restaurant/get_menu_items', to: 'restaurant#get_menu_items'
  
end
