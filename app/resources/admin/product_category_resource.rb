# frozen_string_literal: true

module Admin
  class ProductCategoryResource < ApplicationResource
    self.model = ProductCategory

    belongs_to :product, resource: Admin::ProductResource
    belongs_to :category, resource: Admin::CategoryResource

    primary_endpoint "/product_categories", [:create, :update, :index, :show, :destroy]
  end
end
