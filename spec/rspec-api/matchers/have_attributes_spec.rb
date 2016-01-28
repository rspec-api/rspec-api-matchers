require 'spec_helper'
require 'rspec-api/matchers/attributes/have_attributes'

describe 'have_attributes matcher' do
  include RSpecApi::Matchers::Attributes
  let(:response) { OpenStruct.new body: '' }

  describe 'expect(response).to have_attributes(...)' do
    context 'given a JSON collection with 2 items with attributes' do
      before { response.body = '[{"id":1,"name":"one","price":23.12},{"id":2,"name":"one","price":12.99}]' }

      it 'passes given no attributes' do
        expect(response).to have_attributes
      end

      it 'passes given an existing attribute as a symbol' do
        expect(response).to have_attributes :id
      end

      it 'passes given an existing attribute as a string' do
        expect(response).to have_attributes 'id'
      end

      it 'passes given an existing attribute as a hash key' do
        expect(response).to have_attributes id: {}
      end

      it 'fails given a missing attribute' do
        expect {
          expect(response).to have_attributes :something_else
        }.to fail_with %r{expected body to have attributes .+?, but got}
      end

      it 'passes given an array of existing attributes' do
        expect(response).to have_attributes :id, :name
      end

      it 'fails given a missing attribute in an array' do
        expect {
          expect(response).to have_attributes :id, :something_else
        }.to fail_with %r{expected body to have attributes .+?, but got}
      end

      it 'passes given a hash of existing attributes' do
        expect(response).to have_attributes id: {}, name: {}
      end

      it 'fails given a missing attribute in a hash' do
        expect {
          expect(response).to have_attributes id: {}, something_else: {}
        }.to fail_with %r{expected body to have attributes .+?, but got}
      end

      it 'passes given an existing attribute + value' do
        expect(response).to have_attributes name: {value: 'one'}
      end

      it 'fails given an existing attribute with the wrong value' do
        expect {
          expect(response).to have_attributes id: {value: 1}
        }.to fail_with %r{expected body to have attributes .+?, but got}
      end

      it 'passes given an existing attribute + value + type' do
        expect(response).to have_attributes name: {value: 'one', type: :string}
      end

      it 'passes given an existing attribute + value + type + format' do
        expect(response).to have_attributes id: {type: {number: :integer}}, name: {value: 'one', type: :string}
      end

      it 'passes given an existing attribute of float value' do
        expect(response).to have_attributes id: {type: {number: :integer}}, name: {value: 'one', type: :string}, price: {type: {number: :float}}
      end

    end

    it 'passes given a single JSON object (rather than a collection)' do
      response.body = '{"id":1,"site":"http://example.com"}'
      expect(response).to have_attributes :id, site: {type: {string: :url}}
    end

    it 'passes when given an existing *numeric* key/value pair' do
      response.body = '{"id":1.2}'
      expect(response).to have_attributes id: {value: 1.2}
    end

    it 'passes when given an existing *string* key/value pair' do
      response.body = '{"name":"one"}'
      expect(response).to have_attributes name: {value: "one"}
    end

    it 'passes when given an existing *boolean* key/value pair' do
      response.body = '{"flag":true}'
      expect(response).to have_attributes flag: {value: true}
    end

    it 'passes when given an existing *null* key/value pair' do
      response.body = '{"id":null}'
      expect(response).to have_attributes id: {value: nil}
    end

    it 'passes when given an existing *object* key/value pair' do
      response.body = '{"user":{"id":1}}'
      expect(response).to have_attributes user: {value: {id: 1}}
    end

    it 'passes when given an existing *array* key/value pair' do
      response.body = '{"users":[{"id":1},{"id":1}]}'
      expect(response).to have_attributes users: {value: [{id: 1}, {id: 1}]}
    end

    it 'passes when given an existing *Proc* key/value pair' do
      response.body = '[{"id":1},{"id":3},{"id":5}]'
      expect(response).to have_attributes id: {value: -> v {v.odd?}}
    end

    it 'passes when given a key of type *null*' do
      response.body = '{"id":null}'
      expect(response).to have_attributes id: {type: :null}
    end

    it 'passes when given a key of type *string*' do
      response.body = '{"id":"1"}'
      expect(response).to have_attributes id: {type: :string}
    end

    it 'passes when given a key of type *number*' do
      response.body = '[{"id":1},{"id":2.0},{"id":-32.1}]'
      expect(response).to have_attributes id: {type: :number}
    end

    it 'passes when given a key of type *object*' do
      response.body = '[{"id":{}}, {"id":{"name": "two"}}]'
      expect(response).to have_attributes id: {type: :object}
    end

    it 'passes when given a key of type *array*' do
      response.body = '[{"id":[{}]}, {"id":[]}]'
      expect(response).to have_attributes id: {type: :array}
    end

    it 'passes when given a key of type *boolean*' do
      response.body = '[{"id":true}, {"id":false}]'
      expect(response).to have_attributes id: {type: :boolean}
    end

    it 'passes when given a key of type written as a string' do
      response.body = '[{"id":true}, {"id":false}]'
      expect(response).to have_attributes id: {type: 'boolean'}
    end

    it 'passes when given any key and type *any*' do
      response.body = '[{"id":true}, {"id":false}]'
      expect(response).to have_attributes id: {type: :any}
    end

    it 'passes when given a key of one of multiple valid types' do
      response.body = '[{"id":true}, {"id":null}]'
      expect(response).to have_attributes id: {type: [:boolean, :null]}
    end

    it 'passes when given one nested object type' do
      response.body = '{"list":[{"id": 1,"name":"one"},{"id": 2,"name":"two"}]}'
      expect(response).to have_attributes list: {type: {array: [:id]}}
    end

    it 'passes when given one nested object type' do
      response.body = '{"web":{"id": 1,"url": "http://www.example.com"}}'
      expect(response).to have_attributes web: {type: {object: {id: {type: :number}}}}
    end

    it 'passes when given a key of type :string and format :url' do
      response.body = '{"web":"http://www.example.com"}'
      expect(response).to have_attributes web: {type: {string: :url}}
    end

    it 'passes when given a key of type :string and format :timestamp' do
      response.body = '{"done_at":"2013-10-26T23:08:19Z"}'
      expect(response).to have_attributes done_at: {type: {string: :timestamp}}
    end

    it 'passes when given a key of type :string and format :email' do
      response.body = '{"email":"test@example.com"}'
      expect(response).to have_attributes email: {type: {string: :email}}
    end

    it 'passes when given a key of type :string and format as a string' do
      response.body = '{"web":"http://www.example.com"}'
      expect(response).to have_attributes web: {type: {string: 'url'}}
    end

    it 'passes when given a key of multiple types and format :url' do
      response.body = '[{"web":"http://www.example.com"},{"web":null}]'
      expect(response).to have_attributes web: {type: [:null, {string: :url}]}
    end

    it 'passes when given a key of multiple types and formats' do
      response.body = '[{"web":"http://www.example.com"},{"web":123}]'
      expect(response).to have_attributes web: {type: {number: :integer, string: :url}}
    end

    it 'passes when given nested object types' do
      response.body = '{"web":{"id": 1,"url": "http://www.example.com"}}'
      expect(response).to have_attributes web: {type: {object: [:id, url: {type: {string: :url}}]}}
    end

    it 'passes when given nested object types with empty value' do
      response.body = '{"list":[]}'
      expect(response).to have_attributes list: {type: {array: [:id, url: {type: {string: :url}}]}}
    end

    it 'passes when given nested object types and formats' do
      response.body = '{"web":{"id": 1,"url": "http://www.example.com"}}'
      expect(response).to have_attributes web: {type: {object: {id: {type: :number}, url: {type: {string: :url}}}}}
    end

    it 'passes a complex example' do
      response.body = '[{"a":1,"b":[{"c":"x","d":2}]},{"a":3,"b":[{"c":"y","d":2}]},{"a":5,"b":null}]'
      expect(response).to have_attributes 'a' => {type: 'number', value: -> v {v.odd?}}, b: {type: [:null, {'array' => {c: {type: :string}, d: {type: {:'number' => 'integer', 'value' => 2}}}}]}
    end

    it 'passes another complex example' do
      response.body = %Q$[{"where":"HeRe","year":2010,"performers":[{"id":2553,"name":"Artist","website":"http://www.example.com","created_at":"2013-11-02T19:47:52.675Z","updated_at":"2013-11-02T19:47:52.675Z"},{"id":2554,"name":"Artist2","website":"http://www.example.com","created_at":"2013-11-02T19:47:52.679Z","updated_at":"2013-11-02T19:47:52.679Z"}]}]$
      expect(response).to have_attributes :where=>{:type=>:string}, :year=>{:type=>[:null, {:number=>:integer}]}, :performers=>{:type=>{:array=>{:website=>{:type=>[:null, {:string=>:any}]}, :name=>{:type=>:string}}}}
    end

    it 'fails given a non-JSON body' do
      response.body = 'not json'
      expect {
        expect(response).to have_attributes
      }.to fail_with %r{expected body to have attributes, but got}
    end
  end

  describe 'expect(response).not_to have_attributes' do
    it 'passes if the response body does not have all the attributes' do
      response.body = '[{"id":1},{"id":3},{"id":2,"name":"two"}]'
      expect(response).not_to have_attributes name: {type: :string}
    end

    it 'fails if the response body has all the attributes' do
      response.body = '[{"id":1},{"id":2,"name":"two"},{"id":3}]'
      expect {
        expect(response).not_to have_attributes :id
      }.to fail_with %r{expected body not to have attributes .+?, but got}
    end
  end
end


#
#     # DESCRIPTION
#
#     it 'has a concise and meaningful description' do
#       expect(have_attributes.description).to eq %Q{have attributes}
#       expect(have_attributes(id: {value: nil, type: :boolean}).description).to eq %Q{have attributes id=nil (boolean)}
#       expect(have_attributes(id: {}).description).to eq %Q{have attributes id}
#       # TODO: change the next to  "three"?
#       expect(have_attributes(id: {type: :number}, name:{value:"three"}).description).to eq %Q{have attributes id (number) and name=three}
#       expect(have_attributes(id: {type: :not_a_json_type}).description).to eq %Q{have attributes id (not_a_json_type)}
#       expect(have_attributes(id: {}, name:{}).description).to eq %Q{have attributes id and name}
#       expect(have_attributes(id: {value: -> v {v.odd?}}).description).to eq %Q{have attributes id=[Proc value]}
#       expect(have_attributes(id: {type: [:boolean, :null]}).description).to eq %Q{have attributes id (boolean or null)}
#       expect(have_attributes(web: {type: {string: :url, null: :any}}).description).to eq %Q{have attributes web (url string or any null)}
#       # TODO: change the next to  have attributes web (object with attributes id and url (URL string)"
#       expect(have_attributes(web: {type: {object: [:id, {url: {type: {string: :url}}}]}}).description).to eq %Q{have attributes web (object with attributes)}
#       expect(have_attributes(web: {type: [:null, {string: :url}]}).description).to eq %Q{have attributes web (null or url string)}
#       # expect(have_attributes().description).to eq %Q{}
#     end
#
#     ## FAILS WHEN
#
#     it 'fails when the response body is not valid JSON' do
#       response.body = 'this is not valid json'
#       expect {
#         expect(response).to have_attributes :id
#       }.to fail_with %r{expected body to have attributes id, but got}
#     end
#
#     # JUST THE KEY
#
#     it 'fails when given one missing key in an object' do
#       response.body = '{"id":1}'
#       expect {
#         expect(response).to have_attributes not_found: {}
#       }.to fail_with %r{expected body to have attributes not_found}
#     end
#
#     it 'fails when given one key not present in every object' do
#       response.body = '[{"id":1}, {"something_else":2}]'
#       expect {
#         expect(response).to have_attributes id: {}
#       }.to fail_with %r{expected body to have attributes id, but got}
#     end
#
#     it 'fails when given more keys not present in every object' do
#       response.body = '[{"id":1,"name":"one"},{"id":2,"not-a-name":"two"}]'
#       expect {
#         expect(response).to have_attributes id: {}, name: {}
#       }.to fail_with %r{expected body to have attributes id and name, but got}
#     end
#
#     # KEY + VALUE
#
#     it 'fails when given a missing key/value pair' do
#       response.body = '{"id":1}'
#       expect {
#         expect(response).to have_attributes id: {value: 2}
#       }.to fail_with %r{expected body to have attributes id=2, but got}
#     end
#
#     it 'fails when given one missing of many key/value pairs' do
#       response.body = '[{"id":1,"name":"one"},{"id":2,"name":"two"}]'
#       expect {
#         expect(response).to have_attributes name: {value: 'one'}
#       }.to fail_with %r{expected body to have attributes name=one, but got}
#     end
#
#     # KEY + PROC VALUE
#
#     it 'fails when the value does not satisfy the :value Proc' do
#       response.body = '{"id":2}'
#       expect {
#         expect(response).to have_attributes id: {value: -> v {v.odd?}}
#       }.to fail_with %r{expected body to have attributes id=\[Proc value\], but got}
#     end
#
#     it 'passes when not all the multiple values satisfy the :value Proc' do
#       response.body = '[{"id":1},{"id":2}]'
#       expect {
#         expect(response).to have_attributes id: {value: -> v {v.odd?}}
#       }.to fail_with %r{expected body to have attributes id=\[Proc value\], but got}
#     end
#
#     # KEY + VALUE + TYPE
#
#     it 'fails when given an existing key/value pair of the wrong value' do
#       response.body = '{"id":null}'
#       expect {
#         expect(response).to have_attributes id: {value: 1, type: :null}
#       }.to fail_with %r{expected body to have attributes id=1 \(null\), but got}
#     end
#
#     it 'fails when given an existing key/value pair of the wrong type' do
#       response.body = '{"id":null}'
#       expect {
#         expect(response).to have_attributes id: {value: nil, type: :boolean}
#       }.to fail_with %r{expected body to have attributes id=nil \(boolean\), but got}
#     end
#
#     it 'fails when given multiple existing key/value pairs with a wrong value' do
#       response.body = '[{"id":1,"name":"one"},{"id":2,"name":"two"}]'
#       expect {
#         expect(response).to have_attributes id: {type: :number}, name: {value: 'three'}
#       }.to fail_with %r{expected body to have attributes id \(number\) and name=three, but got}
#     end
#
#     # KEY + TYPE
#
#     it 'fails when given a key of the wrong type' do
#       response.body = '{"id":"not-a-number"}'
#       expect {
#         expect(response).to have_attributes id: {type: :number}
#       }.to fail_with %r{expected body to have attributes id \(number\), but got}
#     end
#
#     it 'fails when given a key of none of the admissible types' do
#       response.body = '[{"id":true}, {"id":123}]'
#       expect {
#         expect(response).to have_attributes id: {type: [:boolean, :null]}
#       }.to fail_with %r{expected body to have attributes id \(boolean or null\), but got}
#     end
#
#     it 'fails when not given a basic JSON type' do
#       response.body = '{"id":id}'
#       expect {
#         expect(response).to have_attributes id: {type: :not_a_json_type}
#       }.to fail_with %r{expected body to have attributes id \(not_a_json_type\), but got}
#     end
#
#     it 'fails when given nil as the type' do
#       response.body = '[{"id":true}, {"id":false}]'
#       expect {
#         expect(response).to have_attributes id: {type: nil}
#       }.to fail_with %r{expected body to have attributes id, but got}
#     end
#
#     # KEY + TYPE + FORMAT
#
#     it 'fails when given a key of the wrong format' do
#       response.body = '{"web":"not-a-valid-url"}'
#       expect {
#         expect(response).to have_attributes web: {type: {string: :url}}
#       }.to fail_with %r{expected body to have attributes web \(url string\), but got}
#     end
#
#     it 'fails when given a key of none of the admissible types+formats' do
#       response.body = '[{"web":"http://www.example.com"},{"web":"not-a-url"}]'
#       expect {
#         expect(response).to have_attributes web: {type: [:null, {string: :url}]}
#       }.to fail_with %r{expected body to have attributes web \(null or url string\), but got}
#     end
#
#     it 'fails when given nested object of the wrong types' do
#       response.body = '{"web":{"id": 1,"url":null}}'
#       expect {
#         expect(response).to have_attributes web: {type: {object: [:id, url: {type: {string: :url}}]}}
#       }.to fail_with %r{expected body to have attributes web \(object with attributes\), but got}
#     end
#   end
#
#   describe 'expect(response).not_to have_attributes(...)' do
#     it 'passes when given a missing key' do
#       response.body = '{"id":1}'
#       expect(response).not_to have_attributes not_there: {}
#     end
#
#     it 'fails when given an existing key' do
#       response.body = '{"id":1}'
#       expect {
#         expect(response).not_to have_attributes :id
#       }.to fail_with %r{expected body not to have attributes id, but it did}
#     end
#   end
# end
