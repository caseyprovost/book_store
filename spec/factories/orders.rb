# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    user_id { Faker::Number.number(digits: 4) }
    total { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    completed_at { nil }
    payment_state { "pending" }

    trait :with_line_items do
      after(:create) do |order|
        3.times do
          order.line_items << create(:line_item, order: order)
        end
      end
    end
  end
end
