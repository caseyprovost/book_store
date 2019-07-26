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

  has_many :option_value_variants do
    pre_load do |proxy, _|
      proxy.scope.object.eager_load(:option_value_variants)
    end

    assign_each do |option_type, option_value_variants|
      option_value_variants.select do |option_value_variant|
        option_value_variant.option_value.option_type_id == option_type.id
      end
    end
  end

  has_many :variants do
    pre_load do |proxy, _|
      proxy.scope.object.eager_load(:variants)
    end

    assign_each do |option_type, variants|
      variants.select do |variant|
        option_type_ids = variant.option_values.map(&:option_type_id).flatten
        option_type.id.in?(option_type_ids)
      end
    end
  end

  has_many :product_option_types
  has_many :products do
    pre_load do |proxy, _|
      proxy.scope.object.eager_load(:products)
    end

    assign_each do |option_type, products|
      products.select do |product|
        option_type_ids = product.product_option_types.map(&:option_type_id).flatten
        option_type.id.in?(option_type_ids)
      end
    end
  end

  attribute :name, :string
  attribute :position, :integer
  attribute :created_at, :datetime
  attribute :updated_at, :datetime
end
