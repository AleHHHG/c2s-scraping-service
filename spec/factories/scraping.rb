# frozen_string_literal: true

FactoryBot.define do
  factory :scraping do
    task_url { "http://example.com" }
    task_id { 100_000 }
    brand { nil }
    kind { nil }
    price { nil }
    completed { true }
  end
end