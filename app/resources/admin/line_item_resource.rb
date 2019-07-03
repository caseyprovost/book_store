# frozen_string_literal: true
module Admin
  class LineItemResource < ApplicationResource
    self.model = LineItem

    filter :variant_id, :integer do |scope, value|
      eq do |scope, value|
        scope.joins(:variant).where(variants: { id: value })
      end
    end

    filter :product_id, :integer do |scope, value|
      eq do |scope, value|
        scope.joins(:variant).where(variants: { product_id: value })
      end
    end

    filter :order_id, :integer do |scope, value|
      eq do |scope, value|
        scope.joins(:order).where(orders: { id: value })
      end
    end

    belongs_to :order, resource: Admin::OrderResource
    belongs_to :variant, resource: Admin::VariantResource

    attribute :quantity, :integer
    attribute :price, :float

    primary_endpoint '/line_items', [:create, :update, :index, :show, :destroy]
  end
end
