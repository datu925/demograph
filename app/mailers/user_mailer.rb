class UserMailer < ApplicationMailer

  default from: "notifications@demograph.herokuapp.com"

  def welcome_email(user)
    @user = user
    @url = 'demograph.herokuapp.com/login'
    mail(to: @user.email, subject: "Welcome to Demograph")
  end
end