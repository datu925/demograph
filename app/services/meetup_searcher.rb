class MeetupSearcher
  attr_reader :stats, :attendees
  def initialize(url)
    @url = url
    re = /meetup.com\/(.*?)\/events\/(.*?)\//i
    @org = re.match(@url)[1]
    @event_id = re.match(@url)[2]
  end

  def get_rsvps
    rsvps = HTTParty.get("https://api.meetup.com/#{@org}/events/#{@event_id}/rsvps")
    @event_name = rsvps.first["event"]["name"]

    @rsvps = rsvps.map do |rsvp|
      RSVP.new({
                full_name: rsvp["member"]["name"],
                first_name: rsvp["member"]["name"].split(" ").first,
                is_attending: rsvp["response"],
                gender: "null"
              })
    end
  end

  def detect_gender
    GenderDetector.detect_mass(@rsvps)
  end

  def analyze_attendees
    @attendees = @rsvps.select{ |rsvp| rsvp.is_attending == "yes" }

    male = @attendees.select { |attendee| attendee.gender == "male" }.length
    female = @attendees.select { |attendee| attendee.gender == "female" }.length
    neutral = @attendees.select { |attendee| attendee.gender == "not_guessed" }.length
    total = @attendees.length
    ratio = female != 0 ? male / female.to_f : "Undefined (no female attendance"
    @stats = { total: total,
               event_name: @event_name,
               male_percentage: male / total.to_f,
               female_percentage: female / total.to_f,
               uncategorized_percentage: neutral / total.to_f,
               ratio: ratio }
  end

  def get_rsvps_and_analyze
    get_rsvps
    detect_gender
    analyze_attendees
  end
end