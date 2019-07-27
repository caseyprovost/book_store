# frozen_string_literal: true

class OptionValueResource < ApplicationResource
  filter :option_type_id, :integer do |scope, value|
    eq do |scope, value|
      scope.where(option_type_id: value)
    end
  end

  filter :product_option_type_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(option_type: [:product_option_types]).where(
        product_option_types: {id: value}
      )
    end
  end

  filter :product_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(option_type: [:product_option_types]).where(
        product_option_types: {product_id: value}
      )
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

  has_many :product_option_types do
    assign_each do |option_value, product_option_types|
      product_option_types.select do |pot|
        pot.option_type_id == option_value.option_type_id
      end
    end
  end

  has_many :variants do
    assign_each do |option_value, variants|
      variants.select do |variant|
        option_value_ids = variant.option_value_variants.map(&:option_value_id).flatten
        option_value.id.in?(option_value_ids)
      end
    end
  end

  attribute :position, :integer
  attribute :name, :string
  attribute :created_at, :datetime
  attribute :updated_at, :datetime
end
