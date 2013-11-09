require 'rspec-api/matchers/json/matcher'

module RSpecApi
  module Matchers
    module Collection
      class Matcher < Json::Matcher

        def matches?(response)
          super
          json.is_a? Array
        end

        def description
          %Q(be a collection)
        end
      end
    end
  end
end