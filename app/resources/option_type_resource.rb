# frozen_string_literal: true

class OptionTypeResource < ApplicationResource
  filter :product_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:product_option_types).where(product_option_types: { product_id: value })
    end
  end

  attribute :name, :string
  attribute :position, :integer
end
