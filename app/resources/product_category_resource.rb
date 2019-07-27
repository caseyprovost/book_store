# frozen_string_literal: true

class ProductCategoryResource < ApplicationResource
  filter :product_id, :integer do |scope, value|
    eq do |scope, value|
      scope.where(product_id: value)
    end
  end

  filter :category_id, :integer do |scope, value|
    eq do |scope, value|
      scope.where(category_id: value)
    end
  end

  filter :variant_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(product: [:variants]).where(variants: {id: value})
    end
  end

  belongs_to :product
  belongs_to :category

  attribute :created_at, :datetime, readonly: true
  attribute :updated_at, :datetime, readonly: true
end
