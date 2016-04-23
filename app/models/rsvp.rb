class RSVP
  attr_accessor :full_name, :first_name, :is_attending, :gender
  def initialize(args = {})
    @full_name = args[:full_name]
    @first_name = args[:first_name]
    @is_attending = args[:is_attending]
    @gender = args[:gender]
  end
end