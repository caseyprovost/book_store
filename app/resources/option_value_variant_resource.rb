# frozen_string_literal: true

class OptionValueVariantResource < ApplicationResource
  filter :option_value_id, :integer do |scope, value|
    eq do |scope, value|
      scope.where(option_value_id: value)
    end
  end

  filter :option_type_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:option_value).where(option_values: {option_type_id: value})
    end
  end

  filter :variant_id, :integer do |scope, value|
    eq do |scope, value|
      scope.where(variant_id: value)
    end
  end

  belongs_to :option_value
  belongs_to :variant

  attribute :created_at, :datetime
  attribute :updated_at, :datetime
end
