class ClinicGeocoderJob < ActiveJob::Base
  queue_as :default

  def perform(clinic)
    address = [clinic.address_1, clinic.address_2, clinic.address_3, "#{clinic.city}, #{clinic.state} #{clinic.zip_code}"].reject(&:nil?).join("\n")
    geo = Geokit::Geocoders::BingGeocoder.geocode(address)
    clinic.update_attributes(lat: geo.lat, lng: geo.lng) if geo.success?
  end
end
