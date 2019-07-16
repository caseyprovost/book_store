# frozen_string_literal: true

module Admin
  module Api
    module V1
      class OrdersController < BaseController
        def index
          orders = OrderResource.all(params)
          respond_with(orders)
        end

        def show
          order = OrderResource.find(params)
          respond_with(order)
        end

        def create
          order = OrderResource.build(params)

          if order.save
            render jsonapi: order, status: 201
          else
            render jsonapi_errors: order
          end
        end

        def update
          order = OrderResource.find(params)

          if order.update_attributes
            render jsonapi: order
          else
            render jsonapi_errors: order
          end
        end

        def destroy
          order = OrderResource.find(params)

          if order.destroy
            render jsonapi: {meta: {}}, status: 200
          else
            render jsonapi_errors: order
          end
        end
      end
    end
  end
end
