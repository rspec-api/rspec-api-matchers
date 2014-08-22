require 'rspec-api/matchers/headers/matcher'

module RSpecApi
  module Matchers
    module ContentType
      class Matcher < Headers::Matcher
        attr_accessor :content_type

        def initialize(content_type)
          @content_type = content_type
        end

        def matches?(response)
          super && headers.key?('Content-Type') && content_type.match(headers['Content-Type'].downcase)
        end

        def description
          %Q{include 'Content-Type': '#{content_type}'}
        end
      end
    end
  end
end