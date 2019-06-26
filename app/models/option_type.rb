# frozen_string_literal: true

class OptionType < ApplicationRecord
  with_options dependent: :destroy, inverse_of: :option_type do
    has_many :option_values, -> { order(:position) }
  end

  has_many :products, through: :product_option_types

  default_scope { order(:position) }

  acts_as_list
end
