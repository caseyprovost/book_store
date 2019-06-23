# frozen_string_literal: true

FactoryBot.define do
  factory :variant do
    sequence(:name) { |n| "#{Faker::Movies::StarWars.droid}-#{n}" }
    product
    price { Faker::Number.decimal(2)  }
    sku { generate(:sku) }
  end
end
