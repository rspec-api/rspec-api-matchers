RSpec API Matchers
==================

RSpecApi::Matchers lets you express outcomes on the response of web APIs.

    expect(response).to have_status(:not_found)

More documentation and examples about RSpec Api are available at [http://rspec-api.github.io](http://rspec-api.github.io)

[![Build Status](https://travis-ci.org/rspec-api/rspec-api-matchers.png?branch=master)](https://travis-ci.org/rspec-api/rspec-api-matchers)
[![Code Climate](https://codeclimate.com/github/rspec-api/rspec-api-matchers.png)](https://codeclimate.com/github/rspec-api/rspec-api-matchers)
[![Coverage Status](https://coveralls.io/repos/rspec-api/rspec-api-matchers/badge.png)](https://coveralls.io/r/rspec-api/rspec-api-matchers)
[![Dependency Status](https://gemnasium.com/rspec-api/rspec-api-matchers.png)](https://gemnasium.com/rspec-api/rspec-api-matchers)

Install
-------

Add `gem 'rspec-api-matchers'` to your `Gemfile` and run `bundle`.
Or install yourself by running `gem install rspec-api-matchers`.

Available matchers
------------------

    expect(response).to have_status(:ok)
    expect(response).to include_content_type(:json)
    expect(response).to have_prev_page_link
    expect(response).to be_valid_json(Array)
    expect(response).to be_a_jsonp('alert')
    expect(response).to be_sorted(by: :id, verse: :desc)
    expect(response).to be_filtered(10, by: :id)
    expect(response).to have_attributes(id: {value: 1.2}, url: {type: {string: :url}})

How to contribute
=================

Don’t hesitate to send me code comments, issues or pull requests through GitHub!
All feedback is appreciated. Thanks :)