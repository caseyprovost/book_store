# frozen_string_literal: true

module Admin
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

        def create
          variant = VariantResource.build(params)

          if variant.save
            render jsonapi: variant, status: 201
          else
            render jsonapi_errors: variant
          end
        end

        def update
          variant = VariantResource.find(params)

          if variant.update_attributes
            render jsonapi: variant
          else
            render jsonapi_errors: variant
          end
        end

        def destroy
          variant = VariantResource.find(params)

          if variant.destroy
            render jsonapi: {meta: {}}, status: 200
          else
            render jsonapi_errors: variant
          end
        end
      end
    end
  end
end
