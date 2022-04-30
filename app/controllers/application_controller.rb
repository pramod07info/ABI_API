class ApplicationController < ActionController::API

    before_action :authenticate_request

    private 
        def authenticate_request
            secret = Rails.application.secret_key_base
            if request.headers['Authorization']
                encoded_token = request.headers['Authorization'].split(' ')[1]
                token = JWT.decode(encoded_token, secret)
                user_id = token[0]['user_id']
                user = User.find(user_id)
                render json: user
            end
        end
        
end
