class PaymentController < ApplicationController
  require 'stripe'
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']

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

  def payment_intent_group
    payment_intent = Stripe::PaymentIntent.create({
      amount: 10000,
      currency: 'sgd',
      payment_method_types: ['card'],
      transfer_group: params[:order_id],
    })
    
    # Create a Transfer to a connected account (later):
    transfer = Stripe::Transfer.create({
      amount: 7000,
      currency: 'sgd',
      destination: params[:restaurant_id],
      transfer_group: params[:order_id],
    })
    
    # Create a second Transfer to another connected account (later):
    transfer = Stripe::Transfer.create({
      amount: 2000,
      currency: 'sgd',
      destination: params[:deliverer_id],
      transfer_group: params[:order_id],
    })
  end
end