class NotificationsController < ApplicationController
  def create
    event = Event.find_or_create_by(url: params[:event_url], name: params[:event_name])
    notification = Notification.find_or_create_by(event: event, user_id: session[:user_id], days_before: params[:notification][:days_before].to_i)
    ScheduleNotificationJob.perform_now(notification)
    redirect_to notifications_path
  end

  def index
    @notifications = Notification.where(user_id: session[:user_id])
  end

  def destroy
    Notification.find(params[:id]).destroy
    redirect_to notifications_path
  end

end