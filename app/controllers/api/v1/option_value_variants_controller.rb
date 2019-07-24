# frozen_string_literal: true

module Api
  module V1
    class OptionValueVariantsController < BaseController
      def index
        option_value_variants = OptionValueVariantResource.all(params)
        respond_with(option_value_variants)
      end

      def show
        option_value_variant = OptionValueVariantResource.find(params)
        respond_with(option_value_variant)
      end
    end
  end
end
