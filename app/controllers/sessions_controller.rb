class SessionsController < ApplicationController
  def login
    user = User.find_by(email: user_params[:email])
    if user
      return render json: { error: "Wrong password" }, status: :unauthorized unless user.authenticate(params[:password])
    else
      user = User.new(user_params)
      if !user.save
        return render json: { error: "Can not register" }, status: :unprocessable_entity
      end
    end
    token = JsonWebTokenService.encode(user_id: user.id)
    render json: { email: user.email, token: token }, status: :ok
  end

  def user_params
    params.permit(:email, :password)
  end
end
