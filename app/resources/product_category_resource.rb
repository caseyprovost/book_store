# frozen_string_literal: true

class ProductCategoryResource < ApplicationResource
  belongs_to :product, resource: ProductResource
  belongs_to :category, resource: CategoryResource

  primary_endpoint '/api/v1/product_categories', [:index, :show]
  secondary_endpoint '/admin/api/v1/product_categories', [:create, :update, :index, :show, :destroy]
end
