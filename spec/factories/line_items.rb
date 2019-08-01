# frozen_string_literal: true

FactoryBot.define do
  factory :line_item do
    association :order
    association :variant
    quantity { 1 }
    price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end
end
