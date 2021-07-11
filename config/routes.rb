# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  po
  # Account
  post '/signup', to: 'account#signup'
  post '/login', to: 'account#login'
  # Restaurant
  post '/restaurant/signup', to: 'restaurant#signup'
  get '/restaurant/browse', to: 'restaurant#browse'
  # Payment
  post "/payment/payment_intent", to: "payment#payment_intent"

  
>>>>>>> Stashed changes
