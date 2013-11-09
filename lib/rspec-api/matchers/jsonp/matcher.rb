require 'rspec-api/matchers/json/matcher'

module RSpecApi
  module Matchers
    module Jsonp
      class Matcher < Json::Matcher
        attr_accessor :callback

        def initialize(callback)
          @callback = callback
        end

        def matches?(response)
          super && body =~ %r{^#{callback || '.+?'}\((.*?)\)$}
        end

        def description
          %Q(be wrapped in a JSONP callback #{callback}).rstrip
        end
      end
    end
  end
end