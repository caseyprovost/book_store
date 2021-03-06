# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :variants, -> { order(:position) }, inverse_of: :product, dependent: :destroy
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :product_properties, dependent: :destroy, inverse_of: :product
  has_many :properties, through: :product_properties, dependent: :destroy
  has_many :product_option_types, dependent: :destroy
  has_many :option_types, through: :product_option_types
end
