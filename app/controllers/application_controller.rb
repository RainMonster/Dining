class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  include UsersHelper
  include EventsHelper
  include ReservationsHelper

  private

  helper_method :current_user, :unless_current_user, :unless_a_host
end
