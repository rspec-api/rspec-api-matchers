require 'json'

module RSpecApi
  module Matchers
    class Filter
      def initialize(value, options = {})
        @value = value
        @field = options[:by]
        @comparing_with = options[:comparing_with]
      end

      def matches?(response)
        @desc = " by #{@field}#{@comparing_with || '='}#{@value}"
        @body = response.body
        array = extract_json_from @body
        array.all? do |item| # TODO: Don't always use string
          if @comparing_with
            @comparing_with.call @value, item[@field.to_s].to_s
          else
            @value.to_s == item[@field.to_s].to_s
          end
        end
      end
      alias == matches?

      def failure_message_for_should
        "expected body to #{description}, but got #{@body}"
      end

      def failure_message_for_should_not
        "expected body not to #{description}, but it was"
      end

      def description
        %Q(be filtered#{@desc})
      end

    private

      # These go elsewhere

      def extract_json_from(something)
        array = JSON without_callbacks(something)
        if array.is_a?(Array) and array.empty?
          raise RSpec::Core::Pending::PendingDeclaredInExample.new "You are testing if an array is sorted, but the array is empty. Try with more fixtures"
        end
        array
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