class RegistrationsController < ApplicationController
  def create
    unless user_params[:username].present? && user_params[:password].present? && user_params[:email].present?
      render json: { error: 'Username, password, and email are required' }, status: :unprocessable_entity
      return
    end

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
    params.require(:user).permit(:username, :password, :email)
  end
end
