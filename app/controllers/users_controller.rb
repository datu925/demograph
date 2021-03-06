class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      # UserMailer.welcome_email(@user).deliver_now
      redirect_to '/welcome/index'
    else
      flash.now[:error] = @user.errors.full_messages
      render 'new'
    end
  end

  def destroy
  end


  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end