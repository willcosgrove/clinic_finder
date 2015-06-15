require 'test_helper'

class ZipCodeGeocoderTest < ActiveSupport::TestCase

  describe "geocode" do
    it "should take a zip_code and return a [lat, lng]" do
      result = ZipCodeGeocoder.geocode("76134")
      refute_empty(result)
      assert_kind_of(Float, result[0])
      assert_kind_of(Float, result[1])
    end
  end

end
