class RegistrationsController < ApplicationController
  def create
    unless user_params[:email].present? && user_params[:password].present?
      render json: { error: 'email and password are required' }, status: :unprocessable_entity
      return
    end

    user = User.new(user_params)
    begin
      if user.save
        render json: { id: user.id, email: user.email }, status: :created
      else
        render json: user.errors, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotUnique => e
      render json: { error: "email is already in use" }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
