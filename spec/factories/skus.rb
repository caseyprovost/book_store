# frozen_string_literal: true

FactoryBot.define do
  sequence(:sku) { |n| "SKU-#{SecureRandom.uuid}" }
end
