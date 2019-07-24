# frozen_string_literal: true

class OptionTypeResource < ApplicationResource
  filter :product_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:product_option_types).where(product_option_types: {product_id: value})
    end
  end

  filter :variant_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(product_option_types: {product: [:variants]}).where(
        variants: {id: value}
      )
    end
  end

  has_many :option_values
  has_many :option_value_variants
  has_many :product_option_types
  has_many :products

  attribute :name, :string
  attribute :position, :integer
  attribute :created_at, :datetime
  attribute :updated_at, :datetime
end
