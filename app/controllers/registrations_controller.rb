class RegistrationsController < ApplicationController
  def create
    user = User.new(user_params)
    begin
      if user.save
        render json: { id: user.id, username: user.username }, status: :created
      else
        render json: user.errors, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotUnique => e
      render json: { error: "Username is already in use" }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
