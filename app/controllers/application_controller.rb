class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :require_login
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def require_login
    redirect_to signin_path unless logged_in?
  end

  def redirect_if_authenticated
    if logged_in?
      redirect_to articles_path
    end
  end

  def logged_in_user
    unless logged_in?
      redirect_to signin_path
    end
  end
end
