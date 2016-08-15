class WelcomeController < ApplicationController
  def index
  end

  def why
  end

  def about
  end

  def feedback
  end

  def search
    @full_url = params[:event][:url]
    searcher = MeetupSearcher.new(@full_url)

    searcher.get_rsvps_and_analyze
    @event_name = searcher.stats[:event_name]
    @attendees = searcher.attendees
    @stats = searcher.stats

    @notification = Notification.new

  end
end
