# frozen_string_literal: true

require 'sneakers'

class CollectDataWorker
  include Sneakers::Worker

  from_queue 'scraping.run', prefetch: 5, threads: 5

  def work(msg)
    msg = JSON.parse(msg).deep_symbolize_keys
    ScrapingService.execute(msg)
    ack!
  end
end
