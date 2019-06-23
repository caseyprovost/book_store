# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < BaseController
      def index
        categories = CategoryResource.all(params)
        respond_with(categories)
      end

      def show
        category = CategoryResource.find(params)
        respond_with(category)
      end
    end
  end
end
