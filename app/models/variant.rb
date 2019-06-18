# frozen_string_literal: true

class Variant < ApplicationRecord
  belongs_to :product, touch: true, inverse_of: :variants
end
