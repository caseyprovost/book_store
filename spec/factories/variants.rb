# frozen_string_literal: true

FactoryBot.define do
  factory :variant do
    references { '' }
    price_in_cents { 1 }
    sku { 'MyString' }
    position { '' }
  end
end
