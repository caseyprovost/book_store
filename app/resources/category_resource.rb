# frozen_string_literal: true

class CategoryResource < ApplicationResource
  filter :product_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:product_categories).where(product_categories: { product_id: value })
    end
  end

  attribute :name, :string
  attribute :slug, :string

  #primary_endpoint '/api/v1/categories', [:index, :show]
  #secondary_endpoint '/admin/api/v1/categories', [:create, :update, :index, :show, :destroy]
end
