# frozen_string_literal: true

class Scraping < ApplicationRecord
  validates :task_url, :task_id, presence: true

  def event_attributes
    { task_id: task_id ,brand: brand, kind: kind, price: price, completed: completed }
  end
end
