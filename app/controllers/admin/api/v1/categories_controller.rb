# frozen_string_literal: true

module Admin
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

        def create
          category = CategoryResource.build(params)

          if category.save
            render jsonapi: category, status: 201
          else
            render jsonapi_errors: category
          end
        end

        def update
          category = CategoryResource.find(params)

          if category.update_attributes
            render jsonapi: category
          else
            render jsonapi_errors: category
          end
        end

        def destroy
          category = CategoryResource.find(params)

          if category.destroy
            render jsonapi: {meta: {}}, status: 200
          else
            render jsonapi_errors: category
          end
        end
      end
    end
  end
end
