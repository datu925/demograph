class NotificationMailer < ApplicationMailer

  default from: "notifications@demograph.herokuapp.com"

  def notification_email(notification, stats)
    @user = notification.user
    @event = notification.event
    @stats = stats
    mail(to: @user.email, subject: "Demograph notification")
  end
end
