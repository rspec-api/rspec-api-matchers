require 'rspec-api/matchers/response/matcher'
require 'json'

module RSpecApi
  module Matchers
    module Json
      class Matcher < Response::Matcher

        def matches?(response)
          super && json
        end
        alias == matches?

        def description
          %Q(be valid JSON)
        end

      private

        def actual
          body
        end

        def match
          'body'
        end

        def json
          @json ||= JSON strip_callback(body), symbolize_names: true
        rescue JSON::ParserError, JSON::GeneratorError
          nil
        end

        def strip_callback(text)
          callback_pattern = %r[^.+?\((.*?)\)$]
          text =~ callback_pattern ? text.match(callback_pattern)[1] : text
        end
      end
    end
  end
end