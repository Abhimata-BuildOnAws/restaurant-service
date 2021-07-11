# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Account
  post '/signup', to: 'account#signup'
  post '/login', to: 'account#login'

  # Restaurant
  post '/restaurant/signup', to: 'seller#signup'

  # Payment
  post "/payment/payment_intent", to: "payment#payment_intent"
end
