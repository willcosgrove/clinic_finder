require 'test_helper'

class ClinicsControllerTest < ActionController::TestCase
  before(:all) do
    Clinic.reindex
  end

  it "will reply :unauthorized if there is no X-Auth-Token header" do
    get :index
    assert_response :unauthorized
  end

  it "requires an X-Auth-Token header to match ENV['API_TOKEN']" do
    @request.headers['X-Auth-Token'] = ENV['API_TOKEN']
    get :index
    assert_response :success
  end

  it "returns an empty array when no zip code is provided" do
    @request.headers['X-Auth-Token'] = ENV['API_TOKEN']
    get :index
    assert_empty(assigns(:results))
  end

  it "returns results when a zip code is provided" do
    @request.headers['X-Auth-Token'] = ENV['API_TOKEN']
    get :index, zip_code: '76134'
    refute_empty(assigns(:results))
  end
end
