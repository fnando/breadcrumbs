# frozen_string_literal: true

class Breadcrumbs
  module Render
    class Inline < Base # :nodoc: all
      def render
        options = {
          class: "breadcrumbs",
          separator: "&#187;"
        }.merge(default_options)

        html = []
        items = breadcrumbs.items
        size = items.size

        items.each_with_index do |item, i|
          html << render_item(item, i, size)
        end

        separator = tag(:span, options[:separator], class: "separator")

        html.join(" #{separator} ").html_safe
      end

      def render_item(item, i, size)
        text, url, options = *item

        css = [options[:class]].compact
        css << "first" if i.zero?
        css << "last" if i == size - 1
        css << "item-#{i}"

        options[:class] = css.join(" ")
        options[:class].gsub!(/^ *(.*?)$/, '\\1')

        wrap_item(url, text, options)
      end
    end
  end
end
