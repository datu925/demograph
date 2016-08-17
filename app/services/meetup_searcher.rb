class MeetupSearcher
  attr_reader :stats, :attendees
  def initialize(url)
    @url = url
    re = /meetup.com\/(.*?)\/events\/(.*?)\//i
    @org = re.match(@url)[1]
    @event_id = re.match(@url)[2]
  end

  def call_meetup
    HTTParty.get("https://api.meetup.com/#{@org}/events/#{@event_id}/rsvps")
  end

  def get_rsvps(resp)
    @event_name = resp.first["event"]["name"]
    @event_time = resp.first["event"]["time"]

    @rsvps = resp.map do |rsvp|
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
               event_time: @event_time,
               male_percentage: male / total.to_f,
               female_percentage: female / total.to_f,
               uncategorized_percentage: neutral / total.to_f,
               ratio: ratio }
  end

  def get_rsvps_and_analyze
    get_rsvps(call_meetup)
    detect_gender
    analyze_attendees
  end
end