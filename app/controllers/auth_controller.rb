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
    rescue => e
      resp = e
    end
    render json: resp
    return
  end

  def confirm_sign_up
    user_object = {
      USERNAME: params[:username],
      CONFIRMATION_CODE: params[:confirmation_code]
    }
    begin
      resp = Cognito.confirm_sign_up(user_object)
    rescue => e
      resp = e
    end
    render json: resp, status: 200
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