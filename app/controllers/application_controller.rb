class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/', alert: exception.message # change to root_path once you've set it up
  end

  private

  def current_user
    @current_user ||= Current.user
  end

  helper_method :current_user
end
