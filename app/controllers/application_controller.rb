class ApplicationController < ActionController::Base
  set_current_tenant_through_filter
  include Pundit

  before_action :authenticate_user!
  before_action :find_current_tenant

  protect_from_forgery prepend: true

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def find_current_tenant
    @current_organization ||= current_user&.organization
    set_current_tenant(@current_organization)
  end

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to (request.referrer || root_path)
  end
end
