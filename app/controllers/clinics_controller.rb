class ClinicsController < ApplicationController
  def index
    if params[:zip_code]
      @results = Rails.cache.fetch(['results', params[:zip_code]], expires_in: 1.week) do
        lat, lng = ZipCodeGeocoder.geocode(params[:zip_code])
        if lat && lng
          search = Clinic.search "*",
            where: {location: {near: [lat, lng], within: '50mi'}},
            boost_by_distance: {field: :location, origin: [lat, lng]},
            limit: 10,
            load: false
          search.results.map { |result| result.slice(:name, :address_1, :address_2, :address_3, :city, :state, :zip_code, :phone, :fax) }
        else
          []
        end
      end
    else
      @results = []
    end
    render json: @results
  end
end
