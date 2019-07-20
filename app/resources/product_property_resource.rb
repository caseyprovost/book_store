class ProductPropertyResource < ApplicationResource
  belongs_to :product
  belongs_to :property

  attribute :value
end
