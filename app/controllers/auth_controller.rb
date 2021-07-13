class AuthController < ApplicationController
  def sign_in
    user_object = {
      USERNAME: params[:username],
      PASSWORD: params[:password]
    }
    begin
      resp = Cognito.authenticate(user_object)
      if resp.authentication_result.nil?
        render json: {
          challenge_name: resp.challenge_name,
          username: resp.challenge_parameters["USER_ID_FOR_SRP"],
          session: resp.session
        }, status: 200
      else
        render json: resp.authentication_result
      end
    rescue => e
      render json: e
    end
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
      USERNAME: params[:username],
      PASSWORD: params[:password],
      address: params[:address],
      name: params[:name]
    }
    begin
      resp = Cognito.create_user(user_object)
      render json: {
        confirmed: resp.user_confirmed,
        destination: resp.code_delivery_details.destination,
        medium: resp.code_delivery_details.delivery_medium,
        attributes: resp.code_delivery_details.attribute_name,
        user_id: resp.user_sub
      }
    rescue => e
      render json: e
    end
  end

  def confirm_sign_up
    user_object = {
      USERNAME: params[:username],
      CONFIRMATION_CODE: params[:confirmation_code]
    }
    begin
      resp = Cognito.confirm_sign_up(user_object)
      render json: { message: 'User confirmed' }, status: 200
    rescue => e
      render json: e
    end
  end

  def get_user
    begin
      resp = Cognito.get_user(params[:access_token])
      render json: {
        user_id: resp.username,
        user_attributes: resp.user_attributes
      },status: 200
    rescue => e
      render json: e
    end
  end

  # Challenges

  def respond_to_new_password_challenge
    begin
      resp = Cognito.respond_to_new_password_challenge(params[:new_password], params[:address], params[:name], params[:username],params[:session])
      render json: resp.authentication_result
    rescue => e
      render json: e
    end
  end
end