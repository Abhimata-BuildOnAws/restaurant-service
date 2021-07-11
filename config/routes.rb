# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Account
  post '/signup', to: 'account#signup'
  post '/login', to: 'account#login'
  # Restaurant
  post '/restaurant/signup', to: 'restaurant#signup'
  post '/restaurant/login', to: 'restaurant#login'
  get '/restaurant/browse', to: 'restaurant#browse'

  # Payment
  post "/payment/payment_intent", to: "payment#payment_intent"

  # Cognito
  post 'auth/sign_in', to: 'auth#sign_in'
  post 'auth/sign_out', to: 'auth#sign_out'
end
