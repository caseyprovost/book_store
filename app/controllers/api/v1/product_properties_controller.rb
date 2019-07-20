# frozen_string_literal: true

module Api
  module V1
    class ProductPropertiesController < BaseController
      def index
        product_properties = ProductPropertyResource.all(params)
        respond_with(product_properties)
      end

      def show
        product_property = ProductPropertyResource.find(params)
        respond_with(product_property)
      end
    end
  end
end
