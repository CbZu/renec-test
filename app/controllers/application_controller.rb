class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  protected

  def authenticate!
    render json: { error_message: 'unauthorized' }, status: :unauthorized if current_user.nil?
  end

  def current_user
    @current_user ||= User.find(JsonWebTokenService.decode(request.headers['Authorization'])[:user_id])
    return @current_user
  end

end
