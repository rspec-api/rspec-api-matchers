require 'rack/utils'

module RSpecApi
  module Matchers
    class MatchStatus
      def initialize(expected_status)
        @expected_status = expected_status
      end

      def matches?(actual_code)
        @actual_code = actual_code
        actual_code == expected_code
      end
      alias == matches?

      def failure_message_for_should
        "expected #{@actual_code} to #{description}"
      end

      def failure_message_for_should_not
        "expected #{@actual_code} not to #{description}"
      end

      def description
        "be #{@expected_status}"
      end

    private

      def expected_code
        status_to_numeric_code @expected_status
      end

      # Translates an HTTP status symbol or code into the corresponding code
      #
      # @example
      # status_to_code(:ok) # => 200
      # status_to_code(200) # => 200
      # status_to_code(987) # => raise
      def status_to_numeric_code(status)
        code = status.is_a?(Symbol) ? Rack::Utils.status_code(status) : status
        validate_status_code! code
        code
      end

      # Raises an exception if +numeric_code+ is not a valid HTTP status code
      #
      # @example
      # validate_status_code!(200) # => (no error)
      # validate_status_code!(999) # => raise
      def validate_status_code!(code)
        valid_codes = Rack::Utils::SYMBOL_TO_STATUS_CODE.values
        message = "#{code} must be a valid HTTP status code: #{valid_codes}"
        unless valid_codes.include? code
          raise ArgumentError, message
        end
      end
    end
  end
end