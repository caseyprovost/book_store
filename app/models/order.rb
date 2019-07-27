# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :variants, through: :line_items
  has_many :products, through: :variants

  monetize :total_in_cents, as: "total",
                            numericality: {
                              greater_than_or_equal_to: 0,
                            }

  before_save :cache_total

  private

  def cache_total
    self.total_in_cents = line_items.sum(&:price_in_cents)
  end
end
