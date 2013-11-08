require 'json'

module RSpecApi
  module Matchers
    class Collection

      def matches?(response)
        @body = response.body
        json = parse_json_of @body
        json.is_a?(Array)
      end
      alias == matches?

      def failure_message_for_should
        "expected body to #{description}, but got #{@body}"
      end

      def failure_message_for_should_not
        "expected body not to #{description}, but got #{@body}"
      end

      def description
        %Q(be a collection)
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