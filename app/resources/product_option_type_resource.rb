class ProductOptionTypeResource < ApplicationResource
  filter :product_id, :integer do |scope, value|
    eq do |scope, value|
      scope.where(product_id: value)
    end
  end

  filter :option_type_id, :integer do |scope, value|
    eq do |scope, value|
      scope.where(option_type_id: value)
    end
  end

  belongs_to :product
  belongs_to :option_type

  attribute :position, :integer
end
