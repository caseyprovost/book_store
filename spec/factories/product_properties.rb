# frozen_string_literal: true

FactoryBot.define do
  factory :product_property do
    product
    property
    sequence(:value) { |n| "#{Faker::Movies::StarWars.droid}-#{n}" }
  end
end
