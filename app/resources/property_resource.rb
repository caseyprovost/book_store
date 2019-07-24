class PropertyResource < ApplicationResource
  filter :product_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:product_properties).where(product_properties: {product_id: value})
    end
  end

  filter :variant_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(product_properties: {product: [:variants]}).where(
        variants: {id: value}
      )
    end
  end

  attribute :name, :string
  attribute :presentation, :string
end
