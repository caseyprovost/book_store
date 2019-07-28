# frozen_string_literal: true

class VariantResource < ApplicationResource
  filter :product_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:product).where(products: {id: value})
    end
  end

  filter :category_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(product: [:product_categories]).where(
        product_categories: {category_id: value}
      )
    end
  end

  filter :order_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:line_items).where(line_items: {order_id: value})
    end
  end

  filter :option_type_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(option_value_variants: [:option_value]).where(option_values: {option_type_id: value})
    end
  end

  filter :option_value_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:option_values).where(option_values: {id: value})
    end
  end

  belongs_to :product
  has_many :option_value_variants

  has_many :option_values do
    assign_each do |variant, option_values|
      option_values
    end
  end

  has_many :line_items

  has_many :orders do
    assign_each do |variant, orders|
      orders
    end
  end

  has_many :option_types do
    assign_each do |variant, option_types|
      option_types
    end
  end

  attribute :name, :string
  attribute :price, :float
  attribute :sku, :string
  attribute :position, :integer
  attribute :created_at, :datetime, readonly: true
  attribute :updated_at, :datetime, readonly: true
  attribute :product_id, :integer, readonly: true

  attribute :description, :string do
    @object.product.description
  end
end
