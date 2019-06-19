# frozen_string_literal: true

FactoryBot.define do
  factory :variant do
    product
    price_in_cents { Faker::Number.number(6)  }
    sku { generate(:sku) }
  end
end
