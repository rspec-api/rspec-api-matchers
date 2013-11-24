require 'rspec-api/matchers/page_links/matcher'

module RSpecApi
  module Matchers
    module PageLinks
      # Passes if the object includes pagination links in the headers
      #
      # @example Passes if the headers include a link to the previous page
      #   require 'rspec-api-matchers'
      #
      #   headers = {'Link' => '<https://example.com/1>; rel="prev"'}
      #   obj = OpenStruct.new headers: headers
      #
      #   describe 'have_page_links' do
      #     include RSpecApi::Matchers::PageLinks
      #     it { expect(obj).to have_page_links }
      #   end
      #
      #   # => (rspec) 1 example, 0 failures
      #
      # @note The method only checks the presence of a rel="prev" link.
      #   This may be extended in future versions.
      #
      # @see http://tools.ietf.org/html/rfc5988#page-6 RFC 5988 Link header specification
      #
      # @see http://git.io/yRiqYQ have_page_links_spec.rb for more examples
      def have_page_links
        RSpecApi::Matchers::PageLinks::Matcher.new
      end
    end
  end
end
