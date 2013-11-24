require 'rspec-api/matchers/headers/matcher'

module RSpecApi
  module Matchers
    module Headers
      # Passes if the object has a non-empty Hash in the headers.
      #
      # @example Passes if the headers include the content length
      #   require 'rspec-api-matchers'
      #
      #   headers = {'Content-Length' => 17372}
      #   obj = OpenStruct.new headers: headers
      #
      #   describe 'have_headers' do
      #     include RSpecApi::Matchers::Headers
      #     it { expect(obj).to have_headers }
      #   end
      #
      #   # => (rspec) 1 example, 0 failures
      #
      # @see http://git.io/-Wb61A have_headers_spec.rb for more examples
      def have_headers
        RSpecApi::Matchers::Headers::Matcher.new
      end
    end
  end
end