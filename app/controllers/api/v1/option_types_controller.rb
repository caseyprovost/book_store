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
    end
  end
end
