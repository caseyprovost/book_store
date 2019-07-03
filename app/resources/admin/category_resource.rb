# frozen_string_literal: true

module Admin
  class CategoryResource < ApplicationResource
    self.model = Category

    filter :product_id, :integer do |scope, value|
      eq do |scope, value|
        scope.joins(:product_categories).where(product_categories: { product_id: value })
      end
    end

    attribute :name, :string
    attribute :slug, :string

    primary_endpoint '/categories', [:create, :update, :index, :show, :destroy]
  end
end
