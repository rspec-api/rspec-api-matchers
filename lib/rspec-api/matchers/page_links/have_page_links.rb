require 'rspec-api/matchers/page_links/matcher'

module RSpecApi
  module Matchers
    module PageLinks
      # Passes if response headers include pagination links ()
      #
      # @example
      #
      #   # Passes if the headers include a link to the previous page
      #   headers = {'Link' => '<https://example.com/1>; rel="prev"'}
      #   expect(OpenStruct.new headers: headers).to have_page_links
      #
      # @note
      #
      # Checking for the rel="prev" is probably enough for the purpose.
      # See http://tools.ietf.org/html/rfc5988#page-6 for Link specification.
      #
      # For more examples check +have_page_links_spec.rb+.
      def have_page_links
        RSpecApi::Matchers::PageLinks::Matcher.new
      end
    end
  end
end
