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

  belongs_to :product
  has_many :option_value_variants
  has_many :line_items
  has_many :orders

  attribute :name, :string
  attribute :price, :float
  attribute :sku, :string
  attribute :position, :integer
end
