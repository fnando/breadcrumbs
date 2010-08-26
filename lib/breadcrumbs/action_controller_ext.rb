class Breadcrumbs
  module ActionController # :nodoc: all
    def self.included(base)
      base.send :helper_method, :breadcrumbs
    end

    def breadcrumbs
      @breadcrumbs ||= Breadcrumbs.new(self)
    end
  end
end

ActionController::Base.send :include, Breadcrumbs::ActionController
