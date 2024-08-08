# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScrapingCallbackEvent, type: :event do
  describe '#publish!' do
    subject { described_class.new(scraping.event_attributes) }
    let(:scraping) { create(:scraping) }
    before do
      allow(PublisherService).to receive(:publish)
    end

    it 'return queue name' do
      subject.publish!
      expect(subject.queue_name).to include('scraping.callback')
    end
  end
end
