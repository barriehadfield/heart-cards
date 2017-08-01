class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_member!

  def acting_user
    current_member
  end
end
