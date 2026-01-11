module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :authenticate_request!, only: [:login, :register]

      # POST /api/v1/auth/login
      def login
        user = User.find_by(email: params[:email])
        
        if user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: user.id)
          render json: { 
            token: token, 
            user: {
              id: user.id,
              name: user.name,
              email: user.email
            }
          }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      # POST /api/v1/auth/register
      def register
        user = User.new(user_params)
        
        if user.save
          token = JsonWebToken.encode(user_id: user.id)
          render json: { 
            token: token,
            user: {
              id: user.id,
              name: user.name,
              email: user.email
            }
          }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end
