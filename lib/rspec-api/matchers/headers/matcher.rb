require 'rspec-api/matchers/response/matcher'

module RSpecApi
  module Matchers
    module Headers
      class Matcher < Response::Matcher

        def matches?(response)
          super && headers.is_a?(Hash) && headers.any?
        end

        def description
          %Q{be a non-empty Hash}
        end

      private

        def actual
          headers
        end

        def match
          'headers'
        end
      end
    end
  end
end