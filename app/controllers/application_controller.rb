class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  protected

  def authenticate!
    render json: { error: 'unauthorized' }, status: :unauthorized if current_user.nil?
  end

  def current_user
    return if request.headers['Authorization'].nil?
    begin
      @current_user ||= User.find(JsonWebTokenService.decode(request.headers['Authorization'])[:user_id])
      return @current_user
    rescue JWT::DecodeError => e
      render json: { error: 'Invalid token or token is expired' }, status: :unauthorized
    end
  end

end
