class SessionsController < ApplicationController
  def login
    user = User.find_by(email: user_params[:email])
    if user
      if user.authenticate(params[:password])
        token = JsonWebTokenService.encode(user_id: user.id)
        render json: { email: user.email, token: token }, status: :ok
      else
        render json: { error: "Wrong password" }, status: :unprocessable_entity
      end
    else
      user = User.new(user_params)
      if user.save
        render json: { id: user.id, email: user.email }, status: :created
      else
        render json: { error: "Can not register" }, status: :unprocessable_entity
      end
    end
  end

  def user_params
    params.permit(:email, :password)
  end
end
