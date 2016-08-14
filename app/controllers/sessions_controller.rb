class SessionsController < ApplicationController
  def new
  end

  def create
    # byebug
    user = User.find_by(email: params[:session][:email])
    if user.nil?
      flash.now[:error] = ["Email not found."]
      render :new
    else
      if user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to '/welcome/index'
      else
        flash.now[:error] = ["Invalid password."]
        render :new
      end
    end
  end

  def destroy
    session[:user_id] = nil
    render :logout
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end