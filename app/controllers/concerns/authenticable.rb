module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request!
    attr_reader :current_user
  end

  private

  def authenticate_request!
    if authorization_header.present?
      token = authorization_header.split(' ').last
      decoded_token = JsonWebToken.decode(token)
      
      if decoded_token
        @current_user = User.find_by(id: decoded_token[:user_id])
        return if @current_user
      end
    end
    
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end

  def authorization_header
    request.headers['Authorization']
  end
end
