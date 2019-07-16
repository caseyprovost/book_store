# frozen_string_literal: true

module Admin
  module Api
    module V1
      class LineItemsController < BaseController
        def create
          line_item = LineItemResource.build(params)

          if line_item.save
            render jsonapi: line_item, status: 201
          else
            render jsonapi_errors: line_item
          end
        end

        def update
          line_item = LineItemResource.find(params)

          if line_item.update_attributes
            render jsonapi: line_item
          else
            render jsonapi_errors: line_item
          end
        end

        def destroy
          line_item = LineItemResource.find(params)

          if line_item.destroy
            render jsonapi: {meta: {}}, status: 200
          else
            render jsonapi_errors: line_item
          end
        end
      end
    end
  end
end
