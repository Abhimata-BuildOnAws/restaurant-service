# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Restaurant
  post '/restaurant/browse', to: 'restaurant#browse'

  # Payment
  post "/payment/payment_intent", to: "payment#payment_intent"

  # Cognito
  post 'auth/sign_up', to: 'auth#sign_up'
  post 'auth/sign_in', to: 'auth#sign_in'
  post 'auth/sign_out', to: 'auth#sign_out'
  post 'auth/confirm_user', to: 'auth#confirm_sign_up'
  post 'auth/new_password', to: 'auth#respond_to_new_password_challenge'
  post 'auth/current_user', to: 'auth#current_user'
  

  # MenuItem
  post 'menu_item/items_by_restaurant', to: 'menu_item#items_by_restaurant'

  # Order
  post 'order/create', to: 'order#create'
  get 'order/directions', to: 'order#directions'
  get 'order/distance', to: 'order#distance'

  # Tumpang
  post '/tumpang', to: 'hitch#create'
  get '/tumpang', to: 'hitch#get_all'
  post '/tumpang/add_order', to: 'hitch#add_order'
end
