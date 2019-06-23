# frozen_string_literal: true

module Admin
  module Api
    module V1
      class ProductCategoriesController < BaseController
        def index
          product_categories = ProductCategoryResource.all(params)
          respond_with(product_categoies)
        end

        def show
          product_category = ProductCategoryResource.find(params)
          respond_with(product_category)
        end

        def create
          product_category = ProductCategoryResource.build(params)

          if product_category.save
            render jsonapi: product_category, status: 201
          else
            render jsonapi_errors: product_category
          end
        end

        def update
          product_category = ProductCategoryResource.find(params)

          if product_category.update_attributes
            render jsonapi: product_category
          else
            render jsonapi_errors: product_category
          end
        end

        def destroy
          product_category = ProductCategoryResource.find(params)

          if product_category.destroy
            render jsonapi: { meta: {} }, status: 200
          else
            render jsonapi_errors: product_category
          end
        end
      end
    end
  end
end
