RSpec API Matchers
==================

RSpecApi::Matchers lets you express outcomes on the response of web APIs.

    expect(404).to match_status(:not_found)

More documentation and examples about RSpec Api are available at [http://rspec-api.github.io](http://rspec-api.github.io)

[![Build Status](https://travis-ci.org/rspec-api/rspec-api-matchers.png)](https://travis-ci.org/rspec-api/rspec-api-matchers)
[![Code Climate](https://codeclimate.com/github/rspec-api/rspec-api-matchers.png)](https://codeclimate.com/github/rspec-api/rspec-api-matchers)
[![Coverage Status](https://coveralls.io/repos/rspec-api/rspec-api-matchers/badge.png)](https://coveralls.io/r/rspec-api/rspec-api-matchers)
[![Dependency Status](https://gemnasium.com/rspec-api/rspec-api-matchers.png)](https://gemnasium.com/rspec-api/rspec-api-matchers)

Install
-------

Add `gem 'rspec-api-matchers'` to your `Gemfile` and run `bundle`.
Or install yourself by running `gem install rspec-api-matchers`.

Available matchers
------------------

    expect(http_status_code).to match_status(http_status)

How to contribute
=================

Don’t hesitate to send me code comments, issues or pull requests through GitHub!
All feedback is appreciated. Thanks :)