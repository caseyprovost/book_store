# frozen_string_literal: true

class OptionValueResource < ApplicationResource
  filter :option_type_id, :integer do |scope, value|
    eq do |scope, value|
      scope.where(option_type_id: value)
    end
  end

  filter :variant_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:option_value_variants).where(
        option_value_variants: {variant_id: value}
      )
    end
  end

  belongs_to :option_type
  has_many :option_value_variants
  has_many :variants

  attribute :position, :integer
  attribute :created_at, :datetime
  attribute :updated_at, :datetime
end
