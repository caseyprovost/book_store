class ProductOptionTypeResource < ApplicationResource
  belongs_to :product
  belongs_to :option_type

  attribute :position
end
