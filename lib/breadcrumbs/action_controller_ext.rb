# frozen_string_literal: true

class Breadcrumbs
  module ActionController # :nodoc: all
    def self.included(base)
      base.send :helper_method, :breadcrumbs
    end

    def breadcrumbs
      @breadcrumbs ||= Breadcrumbs.new
    end
  end
end

ActionController::Base.include Breadcrumbs::ActionController
