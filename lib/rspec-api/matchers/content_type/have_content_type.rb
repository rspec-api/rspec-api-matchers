require 'rspec-api/matchers/content_type/matcher'

module RSpecApi
  module Matchers
    module ContentType
      # Passes if the object includes the expected content type in the headers.
      #
      # @param [Symbol or String] type The expected content type. Can either
      #   be the exact Content-Type string or just the format. The special
      #   value +:any+ matches any content type.
      #
      # @example Passes if the headers matches the provided JSON content type
      #   require 'rspec-api-matchers'
      #
      #   headers ={'Content-Type' => 'application/json; charset=utf-8'}
      #   obj = OpenStruct.new headers: headers
      #
      #   describe 'have_content_type' do
      #     include RSpecApi::Matchers::ContentType
      #     it { expect(obj).to have_content_type(:json) }
      #   end
      #
      #   # => (rspec) 1 example, 0 failures
      #
      # @see http://git.io/qwv-RQ have_content_type_spec.rb for more examples
      def have_content_type(type = nil)
        content_type = case type
          when :json then 'application/json; charset=utf-8'
          when :any then %r{}
          else type
        end
        RSpecApi::Matchers::ContentType::Matcher.new content_type
      end
    end
  end
end