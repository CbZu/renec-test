class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:destroy]

  def create
    user = User.find_by(username: user_params[:username])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      head :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def destroy
    reset_session
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
