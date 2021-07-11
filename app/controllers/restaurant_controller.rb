class RestaurantController < ApplicationController
  def signup
    Stripe.api_key = ENV['STRIPE_TEST_KEY']
    account = Stripe::Account.create({
      type: 'express',
    })  
    restaurant = Restaurant.create(email: params[:email], name: params[:name], address: params[:address], contact_no: params[:contact_no],
    stripe_id: account.id)
    account_links = Stripe::AccountLink.create({
      account: account.id,
      refresh_url: 'https://localhost:3000',
      return_url: 'https://localhost:3000',
      type: 'account_onboarding',
    })
    render json: { message: account_links.url }, status: 200
  end
end