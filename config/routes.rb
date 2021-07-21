# frozen_string_literal: true

Rails.application.routes.draw do
  post '/restaurant/browse', to: 'restaurant#browse'
  post '/restaurant/menu', to: 'restaurant#menu'
  post '/restaurant/create', to: 'restaurant#create_restaurant'
  post '/restaurant/add_menu', to: 'restaurant#add_menu_item_to_restaurant'

end
