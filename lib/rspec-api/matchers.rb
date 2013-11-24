require 'rspec/core'
require 'rspec-api/matchers/attributes/have_attributes'
require 'rspec-api/matchers/collection/be_a_collection'
require 'rspec-api/matchers/content_type/have_content_type'
require 'rspec-api/matchers/filter/be_filtered'
require 'rspec-api/matchers/json/be_valid_json'
require 'rspec-api/matchers/jsonp/be_wrapped_in_callback'
require 'rspec-api/matchers/page_links/have_page_links'
require 'rspec-api/matchers/response/be_a_valid_response'
require 'rspec-api/matchers/sort/be_sorted'
require 'rspec-api/matchers/status/have_status'

module RSpecApi
  # Provides RSpec Matchers for RESTful web APIs.
  #
  # To have these matchers available inside of an RSpec `describe` block,
  # tag that block with the `:rspec_api` metadata, or explicitly include the
  # RSpecApi::Matchers module inside the example group
  #
  # @example Tag a `describe` block as `:rspec_api`:
  #   describe "Artists", rspec_api: true do
  #      ... # here you can write `expect(response).to have_status :ok`, etc.
  #   end
  #
  # @example Explicitly include the RSpecApi::Matchers module
  #   describe "Artists" do
  #      include RSpecApi::Matchers
  #      ... # here you can write `expect(response).to have_status :ok`, etc.
  #   end
  module Matchers
    include Attributes
    include Collection
    include ContentType
    include Filter
    include Json
    include Jsonp
    include PageLinks
    include Response
    include Sort
    include Status
  end
end

RSpec.configuration.include RSpecApi::Matchers, rspec_api: true