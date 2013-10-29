require 'coveralls'
Coveralls.wear!

require 'rspec-api/matchers'
Dir['./spec/support/**/*'].each {|f| require f}

RSpec.configure do |config|
  config.order = 'random'
end