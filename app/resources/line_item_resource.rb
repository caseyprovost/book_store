# frozen_string_literal: true

class LineItemResource < ApplicationResource
  filter :variant_id, :integer do |scope, value|
    eq do |scope, value|
      scope.where(variant_id: value)
    end
  end

  filter :product_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:variant).where(variants: {product_id: value})
    end
  end

  filter :order_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:order).where(orders: {id: value})
    end
  end

  belongs_to :order
  belongs_to :variant

  attribute :quantity, :integer
  attribute :price, :float
  attribute :order_id, :integer, readonly: true
  attribute :variant_id, :integer, readonly: true
  attribute :created_at, :datetime, readonly: true
  attribute :updated_at, :datetime, readonly: true
end
