class NotificationMailer < ApplicationMailer

  default from: "notifications@demograph.herokuapp.com"

  def notification_email(notification, stats, total)
    @user = notification.user
    @event = notification.event
    @stats = stats
    @total = total
    mail(to: @user.email, subject: "Demograph notification")
  end
end
