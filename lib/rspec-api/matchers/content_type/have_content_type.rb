require 'rspec-api/matchers/content_type/matcher'

module RSpecApi
  module Matchers
    module ContentType
      # Passes if the response headers specify the provided content +type+
      #
      # @example
      #
      #   # Passes if the headers matches the provided JSON content type
      #   headers ={'Content-Type' => 'application/json; charset=utf-8'}
      #   expect(OpenStruct.new headers: headers).to have_content_type(:json)
      #
      # For more examples check +have_content_type_spec.rb+.
      def have_content_type(type = nil)
        content_type = case type
          when :json then 'application/json; charset=utf-8'
          when :any then %r{}
        end
        RSpecApi::Matchers::ContentType::Matcher.new content_type
      end
    end
  end
end