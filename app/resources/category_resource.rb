# frozen_string_literal: true

class CategoryResource < ApplicationResource
  filter :product_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:product_categories).where(product_categories: {product_id: value})
    end
  end

  filter :variant_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(product_categories: {product: [:variants]}).where(
        variants: {id: value}
      )
    end
  end

  has_many :product_categories

  has_many :products do
    assign_each do |category, products|
      products.select do |product|
        category_ids = product.product_categories.map(&:category_id).flatten
        category.id.in?(category_ids)
      end
    end
  end

  attribute :name, :string
  attribute :slug, :string, readonly: true
  attribute :created_at, :datetime, readonly: true
  attribute :updated_at, :datetime, readonly: true
end
