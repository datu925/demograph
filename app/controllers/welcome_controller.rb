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
    if searcher.valid_url?
      searcher.get_rsvps_and_analyze
      @event_name = searcher.stats[:event_name]
      @event_time = searcher.stats[:event_time]
      @attendees = searcher.attendees
      @stats = searcher.stats

      @notification = Notification.new
    else
      flash[:error] = "Invalid URL - follow the example format exactly."
      redirect_to root_url
    end
  rescue ArgumentError
    flash[:error] = "URL correctly formed, but not a valid Meetup event. Check again"
    redirect_to root_url
  end
end
