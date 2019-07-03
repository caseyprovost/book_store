# frozen_string_literal: true

class LineItemResource < ApplicationResource
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

  belongs_to :order
  belongs_to :variant

  attribute :quantity, :integer
  attribute :price, :float

  primary_endpoint '/api/v1/line_items', [:index, :show, :create, :update, :destroy]
  secondary_endpoint '/admin/api/v1/line_items', [:create, :update, :destroy]
end
