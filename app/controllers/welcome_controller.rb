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
    full_url = params[:event][:url]
    re = /meetup.com\/(.*?)\/events\/(.*?)\//i
    org = re.match(full_url)[1]
    event_id = re.match(full_url)[2]

    rsvps = HTTParty.get("https://api.meetup.com/#{org}/events/#{event_id}/rsvps")

    @rsvps = rsvps.map do |rsvp|
      RSVP.new({
                full_name: rsvp["member"]["name"],
                first_name: rsvp["member"]["name"].split(" ").first,
                is_attending: "null",
                gender: "null"
              })
    end

    GenderDetector.detect_mass(@rsvps)

    male = @rsvps.select { |rsvp| rsvp.gender == "male" }.length
    female = @rsvps.select { |rsvp| rsvp.gender == "female" }.length
    neutral = @rsvps.select { |rsvp| rsvp.gender == "not_guessed" }.length
    total = @rsvps.length
    ratio = female != 0 ? male / female.to_f : "Undefined (no female attendance"
    @stats = { male_percentage: male / total.to_f,
               female_percentage: female / total.to_f,
               uncategorized_percentage: neutral / total.to_f,
               ratio: ratio }
  end
end
