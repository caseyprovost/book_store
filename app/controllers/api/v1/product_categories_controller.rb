# frozen_string_literal: true

module Api
  module V1
    class ProductCategoriesController < BaseController
      def index
        product_categories = ProductCategoryResource.all(params)
        respond_with(product_categories)
      end

      def show
        product_category = ProductCategoryResource.find(params)
        respond_with(product_category)
      end
    end
  end
end
