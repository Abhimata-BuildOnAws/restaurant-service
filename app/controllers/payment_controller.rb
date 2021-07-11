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

  # Takes in total cost and composition of the cost to be paid to restaurant and delivery respectively
  # WIP : Could be calculatedk waiting for Jon
  def payment_intent_group
    payment_intent = Stripe::PaymentIntent.create({
      amount: params[:total_cost],
      currency: 'sgd',
      payment_method_types: ['card'],
      transfer_group: params[:order_id],
    })
    
    # Create a Transfer to a connected account (later):
    transfer = Stripe::Transfer.create({
      amount: params[:food_cost],
      currency: 'sgd',
      destination: params[:restaurant_id],
      transfer_group: params[:order_id],
    })
    
    # Create a second Transfer to another connected account (later):
    transfer = Stripe::Transfer.create({
      amount: params[:delivery_cost],
      currency: 'sgd',
      destination: params[:deliverer_id],
      transfer_group: params[:order_id],
    })
  end
end