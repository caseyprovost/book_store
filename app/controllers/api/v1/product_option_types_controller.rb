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
    end
  end
end
