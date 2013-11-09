require 'rspec-api/matchers/headers/matcher'

module RSpecApi
  module Matchers
    module PageLinks
      class Matcher < Headers::Matcher
        def matches?(response)
          # NOTE: Only use headers.fetch('Link', '') after http://git.io/CUz3-Q
          super && (headers['Link'] || '') =~ %r{<.+?>. rel\="prev"}
        end

        def description
          %Q{include a 'Link' to the previous page}
        end
      end
    end
  end
end