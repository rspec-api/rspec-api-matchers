require 'rspec-api/matchers/attributes/matcher'

module RSpecApi
  module Matchers
    module Attributes
      # Passes if the response body is either a JSON object or a collection of
      # JSON objects that include all the +attributes+.
      #
      # @example
      #
      #   # Passes if the body is an object with a URL-formatted String :site
      #   response = OpenStruct.new body: '{"site": "http://www.example.com"}'
      #   expect(response).to have_attributes(site: {type: {string: :url}})
      #
      # For more examples check +have_attributes_spec.rb+.

      # TODO: add &block options
      def have_attributes(*attributes)
        RSpecApi::Matchers::Attributes::Matcher.new *attributes
      end
    end
  end
end