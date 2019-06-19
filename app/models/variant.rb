# frozen_string_literal: true

class Variant < ApplicationRecord
  belongs_to :product, touch: true, inverse_of: :variants

  delegate :name, :name=, :description, to: :product

  acts_as_list scope: :product
end
