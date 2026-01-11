module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_request!, only: []

      # GET /api/v1/users/me
      def me
        render json: {
          id: current_user.id,
          name: current_user.name,
          email: current_user.email,
          created_at: current_user.created_at
        }
      end

      # PUT /api/v1/users/me
      def update
        if current_user.update(user_params)
          render json: {
            id: current_user.id,
            name: current_user.name,
            email: current_user.email
          }
        else
          render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end
