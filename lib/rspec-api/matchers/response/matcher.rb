require 'ostruct'
require 'json'

module RSpecApi
  module Matchers
    module Response
      class Matcher
        attr_accessor :response

        def matches?(response)
          @response = response || OpenStruct.new
          status || headers || body
        end
        alias == matches?

        def description
          %Q(be a valid response)
        end

        def failure_message_for_should
          "expected #{match} to #{description}, but got #{actual}"
        end

        def failure_message_for_should_not
          "expected #{match} not to #{description}, but got #{actual}"
        end

      private

        def body
          @body ||= response.body
        end

        def headers
          @headers ||= response.headers
        end

        def status
          @status ||= response.status
        end

        def match
          'response'
        end

        def actual
          response
        end
      end
    end
  end
end