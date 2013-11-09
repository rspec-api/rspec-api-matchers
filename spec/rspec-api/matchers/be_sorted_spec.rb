require 'spec_helper'
require 'rspec-api/matchers/sort/be_sorted'

describe 'be_sorted matcher' do
  include RSpecApi::Matchers::Sort
  let(:response) { OpenStruct.new body: '' }

  describe 'expect(response).to be_sorted' do
    context 'given a JSON collection with 3 items sorted by ascending id' do
      before { response.body = '[{"id":1},{"id":2,"name":"two"},{"id":3}]' }

      it 'passes given no sorting field' do
        expect(response).to be_sorted
      end

      it 'passes given the right sorting field' do
        expect(response).to be_sorted by: :id
      end

      it 'fails given the wrong sorting field' do
        expect {
          expect(response).to be_sorted by: :name
        }.to fail_with %r{expected body to be sorted by ascending name, but got}
      end

      it 'fails given a missing field' do
        expect {
          expect(response).to be_sorted by: :key
        }.to fail_with %r{expected body to be sorted by ascending key, but got}
      end

      it 'passes given the right sorting direction' do
        expect(response).to be_sorted by: :id, verse: :asc
      end

      it 'fails given the wrong sorting direction' do
        expect {
          expect(response).to be_sorted by: :id, verse: :desc
        }.to fail_with %r{expected body to be sorted by descending id, but got}
      end
    end

    context 'given a non-empty JSON collection sorted by descending id' do
      before { response.body = '[{"id":3},{"id":2,"name":"two"},{"id":1}]' }

      it 'passes given the right sorting direction' do
        expect(response).to be_sorted by: :id, verse: :desc
      end

      it 'fails given the wrong sorting direction' do
        expect {
          expect(response).to be_sorted by: :id, verse: :asc
        }.to fail_with %r{expected body to be sorted by ascending id, but got}
      end
    end

    it 'is pending given a JSON collection with less than 2 objects' do
      response.body = '[{"id": 1}]'
      expect {
        expect(response).to be_sorted by: :id
      }.to be_pending_with %r{Cannot test sorting on an array with 1 item}
    end

    it 'fails given a collection of objects without the sorting key' do
      response.body = '[{"id": 1},{"name": "two"},{"id": 3}]'
      expect {
        expect(response).to be_sorted by: :id
      }.to fail_with %r{expected body to be sorted by ascending id, but got}
    end

    it 'fails given a collection of non-objects' do
      response.body = '[1, 2, 3]'
      expect {
        expect(response).to be_sorted by: :id
      }.to fail_with %r{expected body to be sorted by ascending id, but got}
    end

    it 'fails given a single JSON object' do
      response.body = '{"id": 1}'
      expect {
        expect(response).to be_sorted by: :id
      }.to fail_with %r{expected body to be sorted by ascending id, but got}
    end

    it 'fails given a non-JSON body' do
      response.body = 'not json'
      expect {
        expect(response).to be_sorted
      }.to fail_with %r{expected body to be sorted, but got}
    end
  end

  describe 'expect(response).not_to be_sorted' do
    it 'passes if the response body is not a sorted collection' do
      response.body = '[{"id":1},{"id":3},{"id":2,"name":"two"}]'
      expect(response).not_to be_sorted by: :id
    end

    it 'fails if the response body is not a sorted collection' do
      response.body = '[{"id":1},{"id":2,"name":"two"},{"id":3}]'
      expect {
        expect(response).not_to be_sorted by: :id
      }.to fail_with %r{expected body not to be sorted by ascending id, but got}
    end
  end
end