class SiteController < ApplicationController
  def home
  end

  def contact
    breadcrumbs.add :pages
    breadcrumbs.add :contact, contact_path
  end
end
