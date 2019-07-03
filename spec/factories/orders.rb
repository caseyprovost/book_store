# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    user_id { Faker::Number.number(4) }
    total { Faker::Number.decimal(2, 2) }
    completed_at { nil }
    payment_state { 'pending' }
  end
end
