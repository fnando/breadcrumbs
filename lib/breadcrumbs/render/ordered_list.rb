# frozen_string_literal: true

class Breadcrumbs
  module Render
    class OrderedList < List # :nodoc: all
      def list_style
        :ol
      end
    end
  end
end
