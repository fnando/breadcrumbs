class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_root_breadcrumb

  private

  def set_root_breadcrumb
    breadcrumbs.add :home, root_path
  end
end
