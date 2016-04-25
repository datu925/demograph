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

    # separate rsvps based on whether they have an entry in the database
    # rsvps with an entry get gender assigned from that
    # rsvps without one make a request below, and make sure to save the results

    names = rsvps.map{ |rsvp| rsvp.first_name }
    found_names = Name.where(name: names)
    found_rsvps = rsvps.select{ |rsvp| found_names.pluck(:name).include? rsvp.first_name }
    unfound_rsvps = rsvps - found_rsvps

    GenderDetector.process_found(found_rsvps)
    GenderDetector.process_unfound(unfound_rsvps)
  end

  def self.process_found(rsvps)
    rsvps.each do |rsvp|
      rsvp.gender = Name.find_by(name: rsvp.first_name).gender
    end
    rsvps
  end

  def self.process_unfound(rsvps)
    rsvps.each_slice(10) do |group|
      names = group.map {|rsvp| rsvp.first_name }
      name_list = Gendered::NameList.new(names)
      name_list.guess!
      GenderDetector.save_name_data(name_list)
      group.each_with_index do |rsvp, index|
        rsvp.gender = name_list.names[index].gender.to_s
      end
    end
    rsvps
  end

  def self.save_name_data(name_list)
    name_list.each do |name|
      Name.create({
                    name: name.value,
                    gender: name.gender,
                    probability: name.probability,
                    count: name.sample_size
                  })
    end
  end
end