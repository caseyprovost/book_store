# frozen_string_literal: true

module Api
  module V1
    class PropertiesController < BaseController
      def index
        property = PropertyResource.all(params)
        respond_with(property)
      end

      def show
        property = PropertyResource.find(params)
        respond_with(property)
      end
    end
  end
end
