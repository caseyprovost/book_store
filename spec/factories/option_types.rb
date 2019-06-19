# frozen_string_literal: true

FactoryBot.define do
  factory :option_type do
    sequence(:name) { |n| "#{Faker::Movies::HarryPotter.spell}-#{n}" }
  end
end
