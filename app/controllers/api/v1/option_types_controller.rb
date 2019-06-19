# frozen_string_literal: true

module Api
  module V1
    class OptionTypesController < BaseController
      def index
        option_types = OptionTypeResource.all(params)
        respond_with(option_types)
      end

      def show
        option_type = OptionTypeResource.find(params)
        respond_with(option_type)
      end

      def create
        option_type = OptionTypeResource.build(params)

        if option_type.save
          render jsonapi: option_type, status: 201
        else
          render jsonapi_errors: option_type
        end
      end

      def update
        option_type = OptionTypeResource.find(params)

        if option_type.update_attributes
          render jsonapi: option_type
        else
          render jsonapi_errors: option_type
        end
      end

      def destroy
        option_type = OptionTypeResource.find(params)

        if option_type.destroy
          render jsonapi: { meta: {} }, status: 200
        else
          render jsonapi_errors: option_type
        end
      end
    end
  end
end
