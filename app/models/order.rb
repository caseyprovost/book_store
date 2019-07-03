# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  monetize :total_in_cents, as: 'total',
    numericality: {
      greater_than_or_equal_to: 0
    }
end
