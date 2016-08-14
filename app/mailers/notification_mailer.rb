class NotificationMailer < ApplicationMailer

  default from: "notifications@demograph.herokuapp.com"

  def notification_email(notification)
    @user = notification.user
    @event = notification.event
    mail(to: @user.email, subject: "Demograph notification")
  end
end
