# frozen_string_literal: true

FactoryBot.define do
  factory :option_type_value do
    name { 'MyString' }
    option_type
  end
end
