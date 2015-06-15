require 'test_helper'

class ClinicsControllerTest < ActionController::TestCase
  it "will reply :unauthorized if there is no X-Auth-Token header" do
    get :index
    assert_response :unauthorized
  end

  it "requires an X-Auth-Token header to match ENV['API_TOKEN']" do
    @request.headers['X-Auth-Token'] = ENV['API_TOKEN']
    get :index
    assert_response :success
  end
end
