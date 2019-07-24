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

  attribute :name, :string
  attribute :slug, :string
  attribute :created_at, :datetime
  attribute :updated_at, :datetime
end
