class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize_request

  protected

  def authorize_request
    render status: :unauthorized, nothing: true if request.headers['X-Auth-Token'] != ENV['API_TOKEN']
  end
end
