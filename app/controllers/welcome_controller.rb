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
      [rsvp["member"]["name"], GenderDetector.detect_name(rsvp["member"]["name"])]
    end
    # name_list = Gendered::NameList.new(@names)
    # binding.pry
    # name_list.guess!
    male = @names.select { |name| name[1] == "male" }.length
    female = @names.select { |name| name[1] == "female" }.length
    neutral = @names.select { |name| name[1] == "neutral" }.length
    total = @names.length
    @stats = { male_percentage: male / total.to_f,
               female_percentage: female / total.to_f,
               uncategorized_percentage: neutral / total.to_f }
  end
end
