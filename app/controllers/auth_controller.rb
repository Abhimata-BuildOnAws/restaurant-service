# frozen_string_literal: true

class AuthController < ApplicationController
  def sign_in
    user_object = {
      USERNAME: params[:email],
      PASSWORD: params[:password]
    }
    begin
      resp = Cognito.authenticate(user_object)
      if resp.authentication_result.nil?
        render json: {
          challenge_name: resp.challenge_name,
          username: resp.challenge_parameters['USER_ID_FOR_SRP'],
          session: resp.session
        }, status: 200
      else
        render json: resp.authentication_result
      end
    rescue StandardError => e
      render json: e
    end
  end

  def refresh
    resp = Cognito.refresh(params[:refresh_token])
    render json: resp.authentication_result
  end

  def sign_out
    if request.headers['Authorization']
      Cognito.sign_out(request.headers['Authorization'])
      resp = { type: 'success', message: 'now you are disconected' }
    else
      resp = { type: 'error', message: 'empty token' }
    end
    render json: resp
  end

  def sign_up
    user_object = {
      USERNAME: params[:email],
      PASSWORD: params[:password],
      address: params[:address],
      name: params[:name],
      user_type: params[:user_type]
    }
    begin
      resp = Cognito.create_user(user_object)
      case params[:user_type].downcase
      when 'restaurant'
        create_restaurant(resp.user_sub, params)
      when 'user'
        create_user(resp.user_sub, params)
        render json: {
          confirmed: resp.user_confirmed,
          destination: resp.code_delivery_details.destination,
          medium: resp.code_delivery_details.delivery_medium,
          attributes: resp.code_delivery_details.attribute_name,
          user_id: resp.user_sub
        }
      end
    rescue StandardError => e
      render json: e
    end
  end

  def confirm_sign_up
    user_object = {
      USERNAME: params[:email],
      CONFIRMATION_CODE: params[:confirmation_code]
    }
    begin
      resp = Cognito.confirm_sign_up(user_object)
      render json: { message: 'User confirmed' }, status: 200
    rescue StandardError => e
      render json: e
    end
  end

  # Challenges

  def respond_to_new_password_challenge
    resp = Cognito.respond_to_new_password_challenge(params[:new_password], params[:address], params[:name],
                                                     params[:user_id], params[:session])
    render json: resp.authentication_result
  rescue StandardError => e
    render json: e
  end

  private

  # Creation of Models
  def create_restaurant(user_id, params)
    restaurant = Restaurant.create(id: user_id, email: params[:email], name: params[:name],
                                   street: params[:address], state: params[:state],
                                   country: params[:country], contact_no: params[:contact_no])
    raise Errors::RestaurantCreationError unless restaurant.errors.empty?

    # Stripe account creation
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    account = Stripe::Account.create({
                                       type: 'express'
                                     })
    restaurant.update(stripe_id: account.id)

    account_links = Stripe::AccountLink.create({
                                                 account: account.id,
                                                 refresh_url: 'https://localhost:3000',
                                                 return_url: 'https://localhost:3000',
                                                 type: 'account_onboarding'
                                               })
    # render json: { stripe_url: account_links.url }, status: 200
    redirect_to account_links.url
  end

  def create_user(user_id, params)
    user = User.create(id: user_id, email: params[:email],
                       name: params[:name], street: params[:address],
                       state: params[:state], country: params[:country])
    raise Errors::UserCreationError unless user.errors.empty?
  end
end
