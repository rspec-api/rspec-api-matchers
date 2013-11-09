require 'rack/utils'
require 'rspec-api/matchers/response/matcher'

module RSpecApi
  module Matchers
    module Status
      class Matcher < Response::Matcher
        attr_accessor :status_symbol_or_code

        def initialize(status_symbol_or_code)
          @status_symbol_or_code = status_symbol_or_code
        end

        def matches?(response)
          super && status == status_code
        end

        def description
          "be #{status_code}"
        end

      private

        def status_code
          to_code status_symbol_or_code
        end

        def to_code(symbol_or_code)
          if symbol_or_code.is_a? Symbol
            Rack::Utils.status_code symbol_or_code
          else
            symbol_or_code
          end
        end

        def actual
          status
        end

        def match
          'status code'
        end
      end
    end
  end
end