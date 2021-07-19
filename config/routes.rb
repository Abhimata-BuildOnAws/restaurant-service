# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Restaurant
  post '/restaurant/browse', to: 'restaurant#browse'

  # Payment
  post '/payment/payment_intent', to: 'payment#payment_intent'

  # Cognito
  post 'auth/sign_up', to: 'auth#sign_up'

  # User
  post 'user/update_location', to: 'user#update_location'

  # MenuItem
  post 'menu_item/items_by_restaurant', to: 'menu_item#items_by_restaurant'

  # Order
  post 'order', to: 'order#create'
  get 'order/directions', to: 'order#directions'
  get 'order/distance', to: 'order#distance'

  # Tumpang
  post '/tumpang', to: 'hitch#create'
  post '/tumpang/browse', to: 'hitch#get_all'
  post '/tumpang/add_order', to: 'hitch#add_order'
end
