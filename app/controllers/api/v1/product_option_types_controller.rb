# frozen_string_literal: true

module Api
  module V1
    class ProductOptionTypesController < BaseController
      def index
        product_option_types = ProductOptionTypeResource.all(params)
        respond_with(product_option_types)
      end

      def show
        product_option_type = ProductOptionTypeResource.find(params)
        respond_with(product_option_type)
      end

      def create
        product_option_type = ProductOptionTypeResource.build(params)

        if product_option_type.save
          render jsonapi: product_option_type, status: 201
        else
          render jsonapi_errors: product_option_type
        end
      end

      def update
        product_option_type = ProductOptionTypeResource.find(params)

        if product_option_type.update_attributes
          render jsonapi: product_option_type
        else
          render jsonapi_errors: product_option_type
        end
      end

      def destroy
        product_option_type = ProductOptionTypeResource.find(params)

        if product_option_type.destroy
          render jsonapi: { meta: {} }, status: 200
        else
          render jsonapi_errors: product_option_type
        end
      end
    end
  end
end
