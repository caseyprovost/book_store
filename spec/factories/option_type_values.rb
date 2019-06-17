# frozen_string_literal: true

FactoryBot.define do
  factory :option_type_value do
    name { 'MyString' }
    position { 1 }
    references { '' }
  end
end
