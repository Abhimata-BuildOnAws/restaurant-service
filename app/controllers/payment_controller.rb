class PaymentController < ApplicationController
  require 'stripe'
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']

  # Takes in amount to be paid and the account to be paid to
  def payment_intent
    payment_intent = Stripe::PaymentIntent.create({
      payment_method_types: ['card'],
      amount: params[:amount],
      currency: 'sgd',
      transfer_data: {
        destination: params[:destination],
      },
    })
    render :json => { client_secret: payment_intent.client_secret }, status: 200
  end
end