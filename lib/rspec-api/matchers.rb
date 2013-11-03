require 'rspec-api/dsl/have_status'
require 'rspec-api/dsl/include_content_type'
require 'rspec-api/dsl/have_prev_page_link'
require 'rspec-api/dsl/be_a_jsonp'
require 'rspec-api/dsl/be_sorted'
require 'rspec-api/dsl/be_valid_json'
require 'rspec-api/dsl/be_filtered'
require 'rspec-api/dsl/have_attributes'
require 'rspec-api/dsl/run_if' # should be the last, for metaprogramming

require 'rspec/matchers'

# Convert RSpecAPI::Matchers classes into RSpec-compatible matchers, e.g.:
# makes RSpecApi::Matchers::Status available as expect(...).to match_status

module RSpecApi
  module Matchers
    module DSL
    end
  end
end

module RSpec
  module Matchers
    # Make RSpecApi::Matchers::DSL methods available inside RSpec
    include ::RSpecApi::Matchers::DSL
  end
end