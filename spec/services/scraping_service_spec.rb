# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScrapingService, type: :service do
  describe '.execute' do
    let(:msg) { { id: 1, url: 'http://example.com' } }
    let(:data) { { brand: 'Brand', kind: 'Kind', price: 100.0 } }
    let(:event_double) { instance_double(ScrapingCallbackEvent, publish!: true) }
    before do
      allow(CollectDataService).to receive(:execute).with(msg[:url]).and_return(data)
    end

    it 'creates a new Scraping with the CollectData attributes' do
      expect(ScrapingCallbackEvent).to receive(:new).and_return(event_double)
      expect { ScrapingService.execute(msg) }.to change(Scraping, :count).by(1)

      scraping = Scraping.last
      expect(scraping.task_id).to eq(msg[:id])
      expect(scraping.task_url).to eq(msg[:url])
      expect(scraping.brand).to eq(data[:brand])
      expect(scraping.kind).to eq(data[:kind])
      expect(scraping.price).to eq(data[:price])
      expect(scraping.completed).to be true
      expect(event_double).to have_received(:publish!)
    end

    context 'when CollectDataService returns nil' do
      before do
        allow(CollectDataService).to receive(:execute).with(msg[:url]).and_return(nil)
      end

      it 'creates a new Scraping without CollectData attributes' do
        expect(ScrapingCallbackEvent).to receive(:new).and_return(event_double)
        expect { ScrapingService.execute(msg) }.to change(Scraping, :count).by(1)

        scraping = Scraping.last
        expect(scraping.task_id).to eq(msg[:id])
        expect(scraping.task_url).to eq(msg[:url])
        expect(scraping.completed).to be false
        expect(event_double).to have_received(:publish!)
      end
    end
  end
end