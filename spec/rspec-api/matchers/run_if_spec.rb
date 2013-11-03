require 'spec_helper'

describe 'run_if matcher' do
  let(:response) { OpenStruct.new headers: {} }
  let(:matcher) { RSpecApi::Matchers::ContentType.new('application/json; charset=utf-8') }

  describe 'expect(response).to run_if(...)' do
    it 'passes with the matcher description given run=true and a matcher that passes' do
      response.headers = {'Content-Type' => 'application/json; charset=utf-8'}
      run = run_if true, matcher

      expect(response).to run
      expect(run.description).to eq %Q{include 'Content-Type': 'application/json; charset=utf-8'}
    end

    it 'fails with the matcher error given run=true and a matcher that fails' do
      response.headers = {'Content-Type' => 'application/xml; charset=utf-8'}
      run = run_if true, matcher

      expect {
        expect(response).to run
      }.to fail_with %r{expected headers to include 'Content-Type': 'application/json; charset=utf-8', but got}
    end

    it 'passes with a custom description given run=false' do
      run = run_if false, matcher

      expect(response).to run
      expect(run.description).to eq %Q{not be expected to include any specific 'Content-Type'}
    end
  end

  describe 'expect(response).not_to run_if(...)' do
    it 'passes with the matcher description given run=true and a matcher that fails' do
      response.headers = {'Content-Type' => 'application/xml; charset=utf-8'}
      run = run_if true, matcher

      expect(response).not_to run
      expect(run.description).to eq %Q{include 'Content-Type': 'application/json; charset=utf-8'}
    end

    it 'fails with the matcher error given run=true and a matcher that passes' do
      response.headers = {'Content-Type' => 'application/json; charset=utf-8'}
      run = run_if true, matcher
      expect {
        expect(response).not_to run
      }.to fail_with %r{expected headers not to include 'Content-Type': 'application/json; charset=utf-8', but got}
    end

    it 'passes with a custom description given run=false' do
      run = run_if false, matcher

      expect(response).not_to run
      expect(run.description).to eq %Q{not be expected to include any specific 'Content-Type'}
    end
  end
end
