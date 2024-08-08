# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scraping, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:task_url) }
    it { should validate_presence_of(:task_id) }
  end
end