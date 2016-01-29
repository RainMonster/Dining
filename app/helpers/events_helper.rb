module EventsHelper
  def unless_a_host
    unless current_user.host?
      redirect_to user_path current_user
    end
  end
end
