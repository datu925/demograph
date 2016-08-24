class NotificationsController < ApplicationController
  # def create
  #   start_time = Time.at(params[:event_time].to_i / 1000)
  #   event = Event.find_or_create_by(url: params[:event_url], name: params[:event_name], start_date: start_time)
  #   notification = Notification.find_or_create_by(event: event, user_id: session[:user_id], days_before: params[:notification][:days_before].to_i)
  #   target_date = (event.start_date - notification.days_before.days).to_time
  #   ScheduleNotificationJob.set(wait_until: target_date).perform_later(notification)
  #   redirect_to notifications_path
  # end

  # def index
  #   @notifications = Notification.where(user_id: session[:user_id])
  # end

  # def destroy
  #   Notification.find(params[:id]).destroy
  #   redirect_to notifications_path
  # end

end