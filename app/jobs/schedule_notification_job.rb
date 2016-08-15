class ScheduleNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(notification)

    @full_url = notification.event.url
    searcher = MeetupSearcher.new(@full_url)

    searcher.get_rsvps_and_analyze
    @event_name = searcher.stats[:event_name]
    @stats = searcher.stats
    NotificationMailer.notification_email(notification, @stats).deliver_now
  end
end
