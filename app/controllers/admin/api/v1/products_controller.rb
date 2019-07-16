# frozen_string_literal: true

module Admin
  module Api
    module V1
      class ProductsController < BaseController
        def index
          products = ProductResource.all(params)
          respond_with(products)
        end

        def show
          product = ProductResource.find(params)
          respond_with(product)
        end

        def create
          product = ProductResource.build(params)

          if product.save
            render jsonapi: product, status: 201
          else
            render jsonapi_errors: product
          end
        end

        def update
          product = ProductResource.find(params)

          if product.update_attributes
            render jsonapi: product
          else
            render jsonapi_errors: product
          end
        end

        def destroy
          product = ProductResource.find(params)

          if product.destroy
            render jsonapi: {meta: {}}, status: 200
          else
            render jsonapi_errors: product
          end
        end
      end
    end
  end
end
