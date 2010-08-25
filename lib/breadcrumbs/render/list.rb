class Breadcrumbs
  module Render
    class List < Base # :nodoc: all
      def render
        options = {
          :class => "breadcrumbs",
          :format => :list
        }.merge(default_options)

        list_style = options[:format] == :list ? :ul : :ol

        tag(list_style, options) do
          html = ""
          items = breadcrumbs.items
          size = items.size

          items.each_with_index do |item, i|
            html << render_item(item, i, size)
          end

          html
        end
      end

      def render_item(item, i, size)
        css = []
        css << "first" if i == 0
        css << "last" if i == size - 1
        css << "item-#{i}"

        text, url, options = *item
        text = wrap_item(url, CGI.escapeHTML(text), options)
        tag(:li, text, :class => css.join(" "))
      end

    end
  end
end
