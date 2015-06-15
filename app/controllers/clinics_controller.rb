class ClinicsController < ApplicationController
  def index
    if params[:zip_code]
      geo = Geokit::Geocoders::MultiGeocoder.geocode(params[:zip_code])
      if geo.success?
        search = Clinic.search "*",
          where: {location: {near: [geo.lat, geo.lng], within: '50mi'}},
          boost_by_distance: {field: :location, origin: [geo.lat, geo.lng]},
          limit: 10,
          load: false
        @results = search.results.map { |result| result.slice(:name, :address_1, :address_2, :address_3, :city, :state, :zip_code, :phone, :fax) }
      else
        @results = []
      end
    else
      @results = []
    end
    render json: @results
  end
end
