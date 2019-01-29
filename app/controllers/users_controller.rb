class UsersController < ApplicationController

  def index
    if params[:me].present?
      user = User.find(@current_user.id)
    end
    render json: user
  end

  def show
    user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      render json: {status: 'SUCCESS', message:'User Created'},status: :ok
    else
      render json: {status: 'ERROR', message:@user.errors},status: :unprocessable_entity
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
    end
  end

  private

  def user_params
    params.permit(:name, :last_name, :email, :password, :password_confirmation, :role)
  end
end
