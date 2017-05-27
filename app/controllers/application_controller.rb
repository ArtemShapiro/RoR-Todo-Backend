class ApplicationController < ActionController::Base
  after_action :set_response_headers

  include DeviseTokenAuth::Concerns::SetUserByToken
  include CanCan::ControllerAdditions

  alias current_user current_api_v1_user
  alias authenticate_user! authenticate_api_v1_user!

  def set_response_headers
    response.headers['Cache-Control'] = 'no-cache, no-store'
  end
end
