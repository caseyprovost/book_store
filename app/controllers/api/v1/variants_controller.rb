# frozen_string_literal: true

module Api
  module V1
    class VariantsController < BaseController
      def index
        variants = VariantResource.all(params)
        respond_with(variants)
      end

      def show
        variant = VariantResource.find(params)
        respond_with(variant)
      end
    end
  end
end
