# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :variant

  # validates :quantity, numericality: {only_integer: true, greater_than: 0}

  monetize :price_in_cents, as: "price",
                            numericality: {
                              greater_than_or_equal_to: 0,
                            }

  def product
    variant&.product
  end
end
