# frozen_string_literal: true

FactoryBot.define do
  factory :option_value do
    sequence(:name) { |n| "Size-#{n}" }
    option_type
  end
end
