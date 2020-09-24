# frozen_string_literal: true

class Breadcrumbs
  module Render
    class List < Base # :nodoc: all
      def render
        options = {class: "breadcrumbs"}.merge(default_options)

        tag(list_style, options) do
          html = []
          items = breadcrumbs.items
          size = items.size

          items.each_with_index do |item, i|
            html << render_item(item, i, size)
          end

          html.join.html_safe
        end
      end

      def list_style
        :ul
      end

      def render_item(item, i, size)
        css = []
        css << "first" if i.zero?
        css << "last" if i == size - 1
        css << "item-#{i}"

        text, url, options = *item
        text = wrap_item(url, text, options)
        tag(:li, text, class: css.join(" "))
      end
    end
  end
end
