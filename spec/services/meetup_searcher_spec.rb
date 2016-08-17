require "rails_helper"

=begin

What I should test:
MeetupSearcher splits URL correctly (is this necessary to test if it's private? Do I care about the org and event ID if they're just means to an end?)

Basic story of the object
MeetupSearcher takes a URL as input
MeetupSearcher calls Meetup.com API and receives a response object
MeetupSearcher returns statistics on the object and the "yes" RSVPs
One design choice would be to just lump all statistics into a single stats object, which is what I'm doing now
The other would be to make the API more explicit - the MeetupSearcher has a meetup_name method, etc.
=end


describe MeetupSearcher do
  let(:searcher) { MeetupSearcher.new("https://www.meetup.com/Action-Design-Chicago/events/232753983/")}
  describe "#initialize" do
    it 'returns a searcher (dummy test)' do
      expect(searcher).to be_an_instance_of MeetupSearcher
    end
  end

  describe "#get_rsvps" do
    it 'returns a list of RSVPs' do
      resp_obj = [{"event" => {"name" => "Test event", "time" => "10pm"}, "member" => {"name" => "John Doe"}, "response" => "yes"}, {"event" => {"name" => "Test event", "time" => "10pm"}, "member" => {"name" => "Jim Beam"}, "response" => "no"}]

      expect(searcher.get_rsvps(resp_obj).first).to have_attributes(full_name: "John Doe", first_name: "John", is_attending: "yes", gender: "null")
      expect(searcher.get_rsvps(resp_obj).last).to have_attributes(full_name: "Jim Beam", first_name: "Jim", is_attending: "no", gender: "null")
    end
  end

end