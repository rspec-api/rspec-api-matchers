v0.7.0  - 2013/11/24
--------------------

* Allow Proc as comparison operator for :be_filtered
* Let :be_filtered pass on an array with 1 item
* Add yardoc and better documentation
* Add compatibility with ActiveSupport 3
* Allow content_type as either symbol or string

v0.6.0  - 2013/11/09
--------------------

* Use :value option to specify to value to filter by in be_filtered
* Rename :comparing_with to :compare_with in be_filtered
* Accept a symbol in :compare_with (e.g.: `compare_with: :<`)
* `have_attributes` does not accept a block anymore
* `has_page_links` replaces `has_prev_page_link`
* `have_content_type` replaces `include_content_type`
* `be_wrapped_in_callback` replaces `be_a_jsonp`
* matchers are available by default in examples tagged as :rspec_api

v0.5.0  - 2013/11/07
--------------------

* Respect the version of rspec-api
* Remove unnecessary run_if
* Warn when filter or attributes hit an empty array
* Better description for filter with compare Proc
* Replace be_valid_json with be_a_collection
* include_content_type(:any) always passes
* Rename spec/matchers to spec/dsl

v0.1.0  - 2013/11/03
--------------------

* Added valid_responseontent_type matcher
* Added have_prev_page_link matcher
* Added be_a_collection matcher
* Added be_a_jsonp matcher
* Added be_sorted matcher
* Added be_filtered matcher
* Added have_attributes matcher
* Added run_if, to execute matchers conditionally
* Make sorted/filtered matchers pending if given an empty array


v0.0.1  - 2013/10/29
--------------------

*   Extracted `match_status` from RSpecApi