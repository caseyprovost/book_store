# frozen_string_literal: true

class ProductCategoryResource < ApplicationResource
  belongs_to :product, resource: ProductResource
  belongs_to :category, resource: CategoryResource
end
