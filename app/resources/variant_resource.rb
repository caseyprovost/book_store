# frozen_string_literal: true

class VariantResource < ApplicationResource
  filter :product_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:product).where(products: { id: value })
    end
  end

  belongs_to :product

  attribute :name, :string
  attribute :price, :float
  attribute :sku, :string
  attribute :position, :integer
end
