require 'spec_helper'
require 'rspec-api/matchers/filter/be_filtered'

describe 'be_filtered matcher' do
  include RSpecApi::Matchers::Filter
  let(:response) { OpenStruct.new body: '' }

  describe 'expect(response).to be_filtered' do
    context 'given a JSON collection with 2 items with the same id' do
      before { response.body = '[{"id":1},{"id":1,"name":"two"}]' }

      it 'passes given no options' do
        expect(response).to be_filtered
      end

      it 'passes given the right filter value' do
        expect(response).to be_filtered by: :id, value: 1
      end

      it 'fails given the wrong filter value' do
        expect {
          expect(response).to be_filtered by: :id, value: 2
        }.to fail_with %r{expected body to be filtered by id==2, but got}
      end

      it 'fails given the wrong field' do
        expect {
          expect(response).to be_filtered by: :name, value: 1
        }.to fail_with %r{expected body to be filtered by name==1, but got}
      end
    end

    context 'given a JSON collection with 2 items with id < 5' do
      before { response.body = '[{"id":2},{"id":3,"name":"two"}]' }

      it 'passes given the right comparison method' do
        expect(response).to be_filtered by: :id, value: 5, compare_with: :<
      end

      it 'fails given the wrong comparison method' do
        expect {
          expect(response).to be_filtered by: :id, value: 5, compare_with: :>
        }.to fail_with %r{expected body to be filtered by id>5, but got}
      end

      it 'fails given no comparison method' do
        expect {
          expect(response).to be_filtered by: :id, value: 5
        }.to fail_with %r{expected body to be filtered by id==5, but got}
      end
    end

    it 'is pending given a JSON collection with less than 1 object' do
      response.body = '[]'
      expect {
        expect(response).to be_filtered by: :id
      }.to be_pending_with %r{Cannot test filtering on an array with 0 items}
    end

    it 'fails given a collection of objects without the filtering field' do
      response.body = '[{"id": 1},{"name": "two"},{"id": 1}]'
      expect {
        expect(response).to be_filtered by: :id, value: 1
      }.to fail_with %r{expected body to be filtered by id==1, but got}
    end

    it 'fails given a collection of non-objects' do
      response.body = '[1, 2, 3]'
      expect {
        expect(response).to be_filtered by: :id, value: 1
      }.to fail_with %r{expected body to be filtered by id==1, but got}
    end

    it 'fails given a single JSON object' do
      response.body = '{"id": 1}'
      expect {
        expect(response).to be_filtered by: :id, value: 1
      }.to fail_with %r{expected body to be filtered by id==1, but got}
    end

    it 'fails given a non-JSON body' do
      response.body = 'not json'
      expect {
        expect(response).to be_filtered
      }.to fail_with %r{expected body to be filtered, but got}
    end
  end

  describe 'expect(response).not_to be_filtered' do
    it 'passes given a JSON collection with 2 items without the same id' do
      response.body = '[{"id":1},{"id":3},{"id":2,"name":"two"}]'
      expect(response).not_to be_filtered by: :id, value: 2
    end

    it 'fails given a JSON collection with 2 items with the same id' do
      response.body = '[{"id":1},{"id":1,"name":"two"},{"id":1}]'
      expect {
        expect(response).not_to be_filtered by: :id, value: 1
      }.to fail_with %r{expected body not to be filtered by id==1, but got}
    end
  end
end