require 'rails_helper'

describe GenderDetector do

  describe "#detect_mass" do
    context 'when names are already in names database' do
      it "adds gender information" do
        unprocessed = [RSVP.new({first_name: "John"})]
        name = double("name")
        expect(Name).to receive(:where).with(name: ["John"]).and_return(name)
        allow(name).to receive(:pluck).and_return(["John"])
        allow(Name).to receive(:find_by).and_return(Name.new({gender: "male"}))
        GenderDetector.detect_mass(unprocessed)
        expect(unprocessed.first.gender).to eq "male"
      end
    end

    context 'when names are already in names database' do
      it "returns processed objects when previously unknown" do
      end
    end
  end

end
