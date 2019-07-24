class ProductPropertyResource < ApplicationResource
  filter :product_id, :string do |scope, value|
    eq do |scope, value|
      scope.where(product_id: value)
    end
  end

  filter :property_id, :string do |scope, value|
    eq do |scope, value|
      scope.where(property_id: value)
    end
  end

  filter :variant_id, :string do |scope, value|
    eq do |scope, value|
      scope.joins(product: [:variants]).where(variants: {id: value})
    end
  end

  belongs_to :product
  belongs_to :property

  attribute :value, :string
  attribute :product_id, :integer
  attribute :property_id, :integer
end
