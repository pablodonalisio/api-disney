class UsersController < ApplicationController
  before_action :authorize_request, except: :create

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.with(user: @user, url: login_url).welcome_email.deliver_now!
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
