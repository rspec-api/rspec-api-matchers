RSpecApi::Matchers
==================

RSpecApi::Matchers lets you express outcomes on the response of web APIs.

    expect(response).to have_status(:not_found)

The full documentation is available at [rubydoc.info](http://rubydoc.info/github/rspec-api/rspec-api-matchers/master/frames).

More information about the parent project RSpecApi is available at [rspec-api.github.io](http://rspec-api.github.io)

[![Build Status](https://travis-ci.org/rspec-api/rspec-api-matchers.png?branch=master)](https://travis-ci.org/rspec-api/rspec-api-matchers)
[![Code Climate](https://codeclimate.com/github/rspec-api/rspec-api-matchers.png)](https://codeclimate.com/github/rspec-api/rspec-api-matchers)
[![Coverage Status](https://coveralls.io/repos/rspec-api/rspec-api-matchers/badge.png)](https://coveralls.io/r/rspec-api/rspec-api-matchers)
[![Dependency Status](https://gemnasium.com/rspec-api/rspec-api-matchers.png)](https://gemnasium.com/rspec-api/rspec-api-matchers)

Available matchers
------------------

    expect(response).to have_status(:ok)
    expect(response).to have_content_type(:json)
    expect(response).to have_page_links
    expect(response).to be_a_collection
    expect(response).to be_wrapped_in_callback('alert')
    expect(response).to be_sorted(by: :id, verse: :desc)
    expect(response).to be_filtered(by: :id, value: 10, compare_with: :>)
    expect(response).to have_attributes(id: {value: 1.2}, url: {type: {string: :url}})

How to install
==============

To install on your system, run `gem install rspec-api-matchers`.
To use inside a bundled Ruby project, add this line to the Gemfile:

    gem 'rspec-api-matchers', '~> 0.6.0'

The rspec-api-matchers gem follows [Semantic Versioning](http://semver.org).
Any new release that is fully backward-compatible bumps the *patch* version (0.0.x).
Any new version that breaks compatibility bumps the *minor* version (0.x.0)

Indicating the full version in your Gemfile (*major*.*minor*.*patch*) guarantees
that your project won’t occur in any error when you `bundle update` and a new
version of RSpecApi::Matchers is released.

How to contribute
=================

Don’t hesitate to send me code comments, issues or pull requests through GitHub!

All feedback is appreciated. Thanks :)