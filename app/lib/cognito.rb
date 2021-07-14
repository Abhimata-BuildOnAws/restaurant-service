class Cognito
    @client = Aws::CognitoIdentityProvider::Client.new(
      region: ENV['AWS_COGNITO_REGION'],
      access_key_id: ENV['AWS_ACCESS_KEY'],
      secret_access_key: ENV['AWS_SECRET_KEY']
    )

    def self.authenticate(user_object)
      auth_object = {
        user_pool_id: ENV['AWS_COGNITO_POOL_ID'],
        client_id: ENV['AWS_COGNITO_APP_CLIENT_ID'],
        auth_flow: 'ADMIN_USER_PASSWORD_AUTH',
        auth_parameters: user_object
      }
    
      @client.admin_initiate_auth(auth_object)
    end

    def self.sign_out(access_token)
      @client.global_sign_out(access_token: access_token)
    end
    
    def self.create_user(user_object)
      auth_object = {
        client_id: ENV['AWS_COGNITO_APP_CLIENT_ID'],
        username: user_object[:USERNAME],
        password: user_object[:PASSWORD],
        user_attributes: [
          {
            name: 'name', value: user_object[:name]
          },
          {
            name: 'address', value: user_object[:address]
          },
          {
            name: 'custom:User_Type', value: user_object[:user_type]
          }
        ]
      }
     @client.sign_up(auth_object)
    end

    def self.confirm_sign_up(user_object)
      user_object = {
        client_id: ENV['AWS_COGNITO_APP_CLIENT_ID'],
        username: user_object[:USERNAME],
        confirmation_code: user_object[:CONFIRMATION_CODE]
      }
      @client.confirm_sign_up(user_object)
    end

    def self.get_user(access_token)
      user_object = {
        access_token: access_token
      }
      @client.get_user(user_object)
    end

    # Challenges

    def self.respond_to_new_password_challenge(new_password, address, name, username, session)
      challenge_responses = new_password_challenge(new_password, address, name, username)
      respond_to_challenge(session, 'NEW_PASSWORD_REQUIRED', challenge_responses)
    end

    private

    def self.respond_to_challenge(session, challenge_name, challenge_responses)
      challenge_object = {
        client_id: ENV['AWS_COGNITO_APP_CLIENT_ID'],
        user_pool_id: ENV['AWS_COGNITO_POOL_ID'],
        challenge_name: challenge_name,
        challenge_responses: challenge_responses,
        session: session
      }
      @client.admin_respond_to_auth_challenge(challenge_object)
    end

    def self.new_password_challenge(new_password, address, name, username)
      return {
          USERNAME: username,
          NEW_PASSWORD: new_password,
          'userAttributes.address': address,
          'userAttributes.name': name
        }
    end
  end