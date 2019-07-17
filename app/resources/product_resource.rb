# frozen_string_literal: true

class ProductResource < ApplicationResource
  filter :category_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:product_categories).where(product_categories: {category_id: value})
    end
  end

  many_to_many :categories
  has_many :variants

  attribute :name, :string
  attribute :description, :string
end
