class ProductPropertyResource < ApplicationResource
  filter :product_id, :integer do |scope, value|
    eq do |scope, value|
      scope.where(product_id: value)
    end
  end

  filter :property_id, :integer do |scope, value|
    eq do |scope, value|
      scope.where(property_id: value)
    end
  end

  belongs_to :product
  belongs_to :property

  attribute :value, :string
  attribute :product_id, :string
  attribute :property_id, :string
end
