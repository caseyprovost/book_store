# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "#{Faker::Movies::HarryPotter.house}-#{n}" }
  end
end
