# frozen_string_literal: true

class ProductOptionTypeResource < ApplicationResource
  belongs_to :product, resource: ProductResource
  belongs_to :option_type, resource: OptionTypeResource
end
