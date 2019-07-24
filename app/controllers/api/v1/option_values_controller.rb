# frozen_string_literal: true

module Api
  module V1
    class OptionValuesController < BaseController
      def index
        option_values = OptionValueResource.all(params)
        respond_with(option_values)
      end

      def show
        option_value = OptionValueResource.find(params)
        respond_with(option_value)
      end
    end
  end
end
