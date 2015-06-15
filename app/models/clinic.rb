class Clinic < ActiveRecord::Base
  after_commit :geocode, if: :geocoded_attribute_changed?

  private

  def geocode
    ClinicGeocoderJob.perform_later(self)
  end

  def geocoded_attribute_changed?
    (previous_changes.keys & ["address_1", "address_2", "address_3", "city", "state", "zip_code"]).any?
  end
end
