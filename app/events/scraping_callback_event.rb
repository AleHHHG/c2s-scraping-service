# frozen_string_literal: true

class ScrapingCallbackEvent < BaseEvent
  QUEUE_NAME = 'scraping.callback'

  def initialize(payload)
    @queue_name = QUEUE_NAME
    @payload = payload
  end
end
