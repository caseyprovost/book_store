# frozen_string_literal: true

class Variant < ApplicationRecord
  belongs_to :product, touch: true, inverse_of: :variants
  has_many :option_value_variants
  has_many :option_values, through: :option_value_variants
  has_many :option_types, through: :option_values
  has_many :line_items
  has_many :orders, through: :line_items

  delegate :description, to: :product

  acts_as_list scope: :product

  monetize :price_in_cents, as: "price",
                            numericality: {
                              greater_than_or_equal_to: 0,
                            }
end
