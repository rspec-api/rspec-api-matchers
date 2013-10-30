require 'coveralls'
Coveralls.wear!

require 'rspec-api/matchers'
require 'ostruct'
Dir['./spec/support/**/*'].each {|f| require f}

RSpec.configure do |config|
  config.order = 'random'
end