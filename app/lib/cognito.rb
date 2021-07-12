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
        password: user_object[:PASSWORD]
      }
     @client.sign_up(auth_object)
    end

    def self.respond_to_new_password_challenge(new_password, address, name, challenge)
      puts '--------------cp1----------------------'
      challenge_responses = new_password_challenge(new_password, address, name, challenge)
      puts challenge_responses
      puts '------------cp2----------'
      respond_to_challenge(challenge, challenge_responses)
    end

    private

    def self.respond_to_challenge(challenge, challenge_responses)
      challenge_object = {
        client_id: ENV['AWS_COGNITO_APP_CLIENT_ID'],
        user_pool_id: ENV['AWS_COGNITO_POOL_ID'],
        challenge_name: challenge.challenge_name,
        challenge_responses: challenge_responses,
        session: challenge.session
      }
      @client.admin_respond_to_auth_challenge(challenge_object)
    end

    def self.new_password_challenge(new_password, address, name, challenge)
      return {
          USERNAME: challenge.challenge_parameters["USER_ID_FOR_SRP"],
          NEW_PASSWORD: new_password,
          'userAttributes.address': address,
          'userAttributes.name': name
        }
    end
  end