# frozen_string_literal: true

module Admin
  class VariantResource < ApplicationResource
    self.model = Variant

    filter :product_id, :integer do |scope, value|
      eq do |scope, value|
        scope.joins(:product).where(products: {id: value})
      end
    end

    belongs_to :product, resource: Admin::ProductResource

    attribute :name, :string
    attribute :price, :float
    attribute :sku, :string
    attribute :position, :integer

    primary_endpoint "/variants", [:create, :update, :index, :show, :destroy]
  end
end
