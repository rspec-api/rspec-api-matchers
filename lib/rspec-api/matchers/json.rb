require 'json'

module RSpecApi
  module Matchers
    class Json
      def initialize(type)
        @type = type
        @desc = " #{@type}" if @type
      end

      def matches?(response)
        @body = response.body
        json = parse_json_of @body
        @type ? json.is_a?(@type) : true
      end
      alias == matches?

      def failure_message_for_should
        "expected body to #{description}, but got #{@body}"
      end

      def failure_message_for_should_not
        "expected body not to #{description}, but it was"
      end

      def description
        %Q(be a valid JSON#{@desc})
      end

    private

      # These go elsewhere

      def parse_json_of(something)
        JSON without_callbacks(something)
      rescue JSON::ParserError, JSON::GeneratorError
        nil
      end

      def without_callbacks(something)
        callback_pattern = %r[^.+?\((.*?)\)$]
        something =~ callback_pattern ? something.match(callback_pattern)[1] : something
      end
    end
  end
end