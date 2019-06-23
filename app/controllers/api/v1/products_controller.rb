# frozen_string_literal: true

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
    end
  end
end
