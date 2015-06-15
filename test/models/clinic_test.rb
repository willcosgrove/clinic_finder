require 'test_helper'

class ClinicTest < ActiveSupport::TestCase

  describe :geocoded_attribute_changed do
    let(:clinic) { clinics(:one) }

    it "will return false if the name changes" do
      clinic.update_attributes(name: "foo")
      refute(clinic.send(:geocoded_attribute_changed?))
    end

    it "will return false if the phone changes" do
      clinic.update_attributes(phone: "5555555555")
      refute(clinic.send(:geocoded_attribute_changed?))
    end

    it "will return false if the fax changes" do
      clinic.update_attributes(fax: "5555555555")
      refute(clinic.send(:geocoded_attribute_changed?))
    end

    it "will return true if the city changes" do
      clinic.update_attributes(city: "Dallas")
      assert(clinic.send(:geocoded_attribute_changed?))
    end

    it "will return true if the state changes" do
      clinic.update_attributes(state: "AZ")
      assert(clinic.send(:geocoded_attribute_changed?))
    end

    it "will return true if the address_1 changes" do
      clinic.update_attributes(address_1: "1600 Pennsylvania Ave")
      assert(clinic.send(:geocoded_attribute_changed?))
    end

    it "will return true if the address_2 changes" do
      clinic.update_attributes(address_2: "1600 Pennsylvania Ave")
      assert(clinic.send(:geocoded_attribute_changed?))
    end

    it "will return true if the address_3 changes" do
      clinic.update_attributes(address_3: "1600 Pennsylvania Ave")
      assert(clinic.send(:geocoded_attribute_changed?))
    end
  end
end
