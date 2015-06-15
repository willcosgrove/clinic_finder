class ZipCodeGeocoder

  def self.geocode(zip_code)
    lat_lng = Rails.cache.fetch(zip_code) do
      Geokit::Geocoders::MultiGeocoder.geocode(zip_code).ll
    end
    lat_lng.split(',').map { |coordinate| coordinate.to_f }
  end

end
