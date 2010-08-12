require "i18n" unless defined?(I18n)
require "breadcrumbs/render"
require "breadcrumbs/action_controller_ext" if defined?(ActionController)

class Breadcrumbs
  attr_accessor :items

  def initialize # :nodoc:
    self.items = []
  end

  # Add a new breadcrumbs.
  #
  #   breadcrumbs.add "Home"
  #   breadcrumbs.add "Home", "/"
  #   breadcrumbs.add "Home", "/", :class => "home"
  #
  # If you provide a symbol as text, it will try to
  # find it as I18n scope.
  #
  def add(text, url = nil, options = {})
    options.reverse_merge!(:i18n => true)
    text = translate(text) if options.delete(:i18n)
    items << [text.to_s, url, options]
  end

  # Render breadcrumbs using the specified format.
  # Use HTML lists by default, but can be plain links.
  #
  #   breadcrumbs.render
  #   breadcrumbs.render(:format => :inline)
  #   breadcrumbs.render(:format => :inline, :separator => "|")
  #   breadcrumbs.render(:format => :list)
  #   breadcrumbs.render(:format => :ordered_list)
  #   breadcrumbs.render(:id => "breadcrumbs")
  #   breadcrumbs.render(:class => "breadcrumbs")
  #
  def render(options = {})
    if options[:format] == :inline
      Breadcrumbs::Render::Inline.new(self, options).render
    else
      Breadcrumbs::Render::List.new(self, options).render
    end
  end

  alias :<< :add

  def translate(scope) # :nodoc:
    text = I18n.t(scope, :scope => :breadcrumbs, :raise => true) rescue nil
    text ||= I18n.t(scope, :default => scope.to_s)
    text
  end
end
