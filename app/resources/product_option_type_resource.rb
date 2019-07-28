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

  filter :option_value_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(option_type: [:option_values]).where(option_values: {id: value})
    end
  end

  filter :variant_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(product: [:variants]).where(variants: {id: value})
    end
  end

  belongs_to :product
  belongs_to :option_type
  has_many :option_values do
    assign_each do |pot, option_values|
      option_values.select do |option_value|
        pot.option_type.id == option_value.option_type.id
      end
    end
  end

  attribute :position, :integer
  attribute :product_id, :integer, readonly: true
  attribute :option_type_id, :integer, readonly: true
  attribute :created_at, :datetime, readonly: true
  attribute :updated_at, :datetime, readonly: true
end
