class ApplicationController < ActionController::Base
  set_current_tenant_through_filter

  before_action :authenticate_user!
  before_action :find_current_tenant

  protect_from_forgery prepend: true

  private

  def find_current_tenant
    @current_organization ||= current_user&.organization
    set_current_tenant(@current_organization)
  end
end
