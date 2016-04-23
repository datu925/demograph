module GenderDetector
  def self.detect_free(text)

    unisex_threshold = 0.6

    response = Guess.gender(text)

    percentage = response[:confidence]
    gender = response[:gender]

    if gender == "unknown"
      return "neutral"
    elsif percentage < unisex_threshold && percentage > 1 - unisex_threshold
      return "neutral"
    else percentage
      return gender
    end
  end

  def self.detect_beta(text)

    text = text.split(" ").first
    name = Gendered::Name.new(text)
    name.guess!

    return name.gender.to_s
  end

  def self.detect_mass(rsvps)
    rsvps.each_slice(10) do |group|
      names = group.map {|rsvp| rsvp.first_name }
      name_list = Gendered::NameList.new(names)
      name_list.guess!
      group.each_with_index do |rsvp, index|
        rsvp.gender = name_list.names[index].gender.to_s
      end
    end
    rsvps
  end
end