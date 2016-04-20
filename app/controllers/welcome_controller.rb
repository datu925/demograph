class WelcomeController < ApplicationController
  def index
  end

  def search
    full_url = params[:event][:url]
    re = /meetup.com\/(.*?)\/events\/(.*?)\//i
    org = re.match(full_url)[1]
    event_id = re.match(full_url)[2]

    rsvps = HTTParty.get("https://api.meetup.com/#{org}/events/#{event_id}/rsvps")
    @names = rsvps.map do |rsvp|
      rsvp["member"]["name"]
    end
  end
end
