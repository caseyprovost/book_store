# frozen_string_literal: true

FactoryBot.define do
  factory :product_property do
    product { nil }
    property { nil }
    value { "MyString" }
  end
end
