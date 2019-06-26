# frozen_string_literal: true

class ProductProperty < ApplicationRecord
  with_options inverse_of: :product_properties do
    belongs_to :product, touch: true, class_name: 'Product'
    belongs_to :property, class_name: 'Property'
  end

  acts_as_list scope: :product

  validates :value, presence: true

  default_scope { order(:position) }
end
