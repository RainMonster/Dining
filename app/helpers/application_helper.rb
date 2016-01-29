module ApplicationHelper
  def unless_current_user
    unless current_user
      redirect_to welcome_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def prepend_root_url
    if Rails.env.development?
      "http://localhost:3000"
    elsif Rails.env.production?
      "http://www.nommery.com"
    end
  end
end
