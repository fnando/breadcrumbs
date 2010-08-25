class Breadcrumbs
  module Render
    class Base # :nodoc: all
      attr_accessor :breadcrumbs
      attr_accessor :default_options

      def initialize(breadcrumbs, default_options = {})
        @breadcrumbs = breadcrumbs
        @default_options = default_options
      end

      # Build a HTML tag.
      #
      #   tag(:p, "Hello!")
      #   tag(:p, "Hello!", :class => "hello")
      #   tag(:p, :class => "phrase") { "Hello" }
      #
      def tag(name, *args, &block)
        options = args.pop if args.last.kind_of?(Hash)
        options ||= {}

        content = args.first
        content = self.instance_eval(&block) if block_given?

        attrs = " " + options.collect {|n, v| %[%s="%s"] % [n, v] }.join(" ") unless options.empty?

        %[<#{name}#{attrs}>#{content}</#{name}>]
      end

      protected

        def wrap_item(url, text, options)
          if url
            tag(:a, text, options.merge(:href => url))
          else
            tag(:span, text, options)
          end
        end

    end
  end
end
