require 'rspec-api/matchers/json/matcher'

module RSpecApi
  module Matchers
    module Json
      # Passes if the object has valid JSON or JSONP in the body
      #
      # @example Passes if the body is valid JSON
      #   require 'rspec-api-matchers'
      #
      #   body = '[{"id": 1}]'
      #   obj = OpenStruct.new body: body
      #
      #   describe 'be_valid_json' do
      #     include RSpecApi::Matchers::Json
      #     it { expect(obj).to be_valid_json }
      #   end
      #
      #   # => (rspec) 1 example, 0 failures
      #
      # @note The JSONP option is debatable, since an API that returns a JSONP
      #   should probably set the content-type to application/javascript.
      #
      # @see http://git.io/Rq3lVg be_valid_json_spec.rb for more examples
      def be_valid_json
        RSpecApi::Matchers::Json::Matcher.new
      end
    end
  end
end