require 'rspec-api/matchers/headers/matcher'

module RSpecApi
  module Matchers
    module Headers
      # Passes if the response has a non-empty headers Hash.
      #
      # @example
      #
      #   # Passes if the headers include the content length
      #   headers = {'Content-Length' => 17372}
      #   expect(OpenStruct.new headers: headers).to have_headers
      #
      # For more examples check +have_headers_spec.rb+.
      def have_headers
        RSpecApi::Matchers::Headers::Matcher.new
      end
    end
  end
end