# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class CollectDataService
  class << self
    def execute(url)
      doc = Nokogiri::HTML(URI.open(url))
      { brand: brand(doc), kind: kind(doc),  price: price(doc) }
    rescue
      { }
    end

    private

    def price(doc)
      doc.xpath("//div[contains(@class,'VehicleDetailsFipe__price--announced')]/strong")[0].content.gsub('R$ ','').to_f
    end

    def kind(doc)
      doc.xpath("//h1[@id='VehicleBasicInformationTitle']/strong")[0].content
    end

    def brand(doc)
      doc.xpath("//h1[@id='VehicleBasicInformationTitle']")[0].content.split(' ')[0]
    end
  end
end