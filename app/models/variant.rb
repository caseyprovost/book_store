# frozen_string_literal: true

class Variant < ApplicationRecord
  belongs_to :product, touch: true, inverse_of: :variants

  delegate :description, to: :product

  acts_as_list scope: :product
  monetize :price_in_cents, as: 'price'
end
