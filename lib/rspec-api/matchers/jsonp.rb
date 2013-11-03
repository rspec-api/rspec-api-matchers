module RSpecApi
  module Matchers
    class Jsonp
      def initialize(callback)
        @callback = callback
      end

      def matches?(response)
        @body = response.body
        @body =~ %r{^#{@callback || '.+?'}\((.*?)\)$}
      end
      alias == matches?

      def failure_message_for_should
        "expected body to #{description}, but got #{@body}"
      end

      def failure_message_for_should_not
        "expected body not to #{description}, but it was"
      end

      def description
        %Q(be wrapped in a JSONP callback #{@callback}).rstrip
      end
    end
  end
end