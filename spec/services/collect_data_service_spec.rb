# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe CollectDataService, type: :service do
  let(:url) { 'http://example.com' }
  let(:html_content) { File.read(Rails.root.join('spec/fixtures/webmotors.html')) }

  describe '.execute' do
    before do
      stub_request(:get, url).to_return(body: html_content, headers: { 'Content-Type' => 'text/html' })
    end

    it 'returns the correct data when the page is parsed successfully' do
      result = CollectDataService.execute(url)
      expect(result).to eq({ brand: 'BMW', kind: 'M3', price: 739.900 })
    end

    context 'when an error occurs' do
      before do
        allow(URI).to receive(:open).and_raise(StandardError)
      end

      it 'returns an empty hash' do
        result = CollectDataService.execute(url)
        expect(result).to eq({})
      end
    end
  end

  describe 'private methods' do
    let(:doc) { Nokogiri::HTML(html_content) }

    describe '#price' do
      it 'returns the correct price' do
        result = CollectDataService.send(:price, doc)
        expect(result).to eq(739.900)
      end
    end

    describe '#kind' do
      it 'returns the correct kind' do
        result = CollectDataService.send(:kind, doc)
        expect(result).to eq('M3')
      end
    end

    describe '#brand' do
      it 'returns the correct brand' do
        result = CollectDataService.send(:brand, doc)
        expect(result).to eq('BMW')
      end
    end
  end
end
