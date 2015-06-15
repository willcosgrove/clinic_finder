require 'open-uri'

class ClinicFetcherJob < ActiveJob::Base
  queue_as :default

  def perform
    csv_data = extract_csv(fda_zip_file)
    clinics = parse_csv(csv_data)
    clinics.each do |fda_clinic|
      clinic = Clinic.where(fda_clinic.slice(:name, :zip_code)).first_or_initialize
      clinic.assign_attributes(fda_clinic)
      clinic.save
    end
  end

  private

  def fda_zip_file
    open("http://www.accessdata.fda.gov/premarket/ftparea/public.zip")
  end

  def extract_csv(zip_file)
    Zip::File.open(zip_file).get_input_stream("public.txt")
  end

  def parse_csv(csv_data)
    SmarterCSV.process(csv_data,
      headers_in_file: false,
      col_sep: '|',
      user_provided_headers: [
        :name, :address_1, :address_2, :address_3, :city, :state, :zip_code,
        :phone, :fax
      ]
    )
  end

end
