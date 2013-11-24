require 'rspec-api/matchers/attributes/matcher'

module RSpecApi
  module Matchers
    module Attributes
      # Passes if the object includes the expected attributes in the body.
      #
      # @example Passes if the body is a collection of objects with a URL site
      #   require 'rspec-api-matchers'
      #
      #   body = '[{"site": "http://www.foo.com"}, {"site": "http://bar.com"}]'
      #   obj = OpenStruct.new body: body
      #
      #   describe 'have_attributes' do
      #     include RSpecApi::Matchers::Attributes
      #     it { expect(obj).to have_attributes(site: {type: {string: :url}}) }
      #   end
      #
      #   # => (rspec) 1 example, 0 failures
      #
      # @param [Hash] attributes The expected attributes in the body
      #
      # The method works only if the object is a JSON object or a collection of
      # JSON objects; in the latter case all the objects need to include the
      # expected attributes for the expectation to pass.
      #
      # @see http://git.io/w2dLnw have_attributes_spec.rb for more examples
      def have_attributes(*attributes)
        RSpecApi::Matchers::Attributes::Matcher.new *attributes
      end
    end
  end
end