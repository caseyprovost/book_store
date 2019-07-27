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

  has_many :product_properties
  has_many :products do
    pre_load do |proxy, _|
      proxy.scope.object.eager_load(:products)
    end

    assign_each do |property, products|
      products
    end
  end

  attribute :name, :string
  attribute :presentation, :string
  attribute :created_at, :datetime, readonly: true
  attribute :updated_at, :datetime, readonly: true
end
