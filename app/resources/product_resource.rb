# frozen_string_literal: true

class ProductResource < ApplicationResource
  filter :category_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:product_categories).where(product_categories: {category_id: value})
    end
  end

  filter :option_type_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:product_option_types).where(product_option_types: {option_type_id: value})
    end
  end

  filter :property_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:product_properties).where(product_properties: {property_id: value})
    end
  end

  many_to_many :categories
  many_to_many :properties
  many_to_many :option_types
  has_many :variants

  attribute :name, :string
  attribute :description, :string
  attribute :created_at, :datetime, readonly: true
  attribute :updated_at, :datetime, readonly: true
end
