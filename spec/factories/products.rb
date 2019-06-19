# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name)   { |n| "Product ##{n} - #{Kernel.rand(9999)}" }
    description       { Faker::Lorem.paragraph(2) }
  end
end
