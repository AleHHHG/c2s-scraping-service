# frozen_string_literal: true

class ScrapingService
  class << self
    def execute(msg)
      data = CollectDataService.execute(msg[:url])
      scraping = build_scraping(msg, data)
      ScrapingCallbackEvent.new(scraping.event_attributes).publish!
    end

    private

    def build_scraping(msg, data)
      scraping = Scraping.new
      scraping.task_id = msg[:id]
      scraping.task_url = msg[:url]
      if data.present?
        scraping.brand = data[:brand]
        scraping.kind = data[:kind]
        scraping.price = data[:price]
        scraping.completed = true
      else
        scraping.completed = false
      end
      scraping.save
      scraping
    end
  end
end
