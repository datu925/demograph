class ScheduleNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(notification)
    NotificationMailer.notification_email(notification).deliver_now
  end
end
