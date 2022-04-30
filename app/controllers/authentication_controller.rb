class AuthenticationController < ApplicationController

    skip_before_action :authenticate_request

    def login
        secret = Rails.application.secret_key_base
        user = User.find_by(username: login_params[:username])
        if user 
            if user.authenticate(login_params[:password])
             token = JWT.encode({user_id: user.id}, secret, 'HS256')
             render json: {user: user, token: token}
            else
                render json: {errors: "Invalid password."},status: :unprocessable_entity
            end
        else
            render json: {errors: "Invalid username"},status: :unprocessable_entity
        end
    end

    private

    def login_params
        params.permit(:username, :password)
    end
end
