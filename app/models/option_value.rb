# frozen_string_literal: true

class OptionValue < ApplicationRecord
  belongs_to :option_type, touch: true, inverse_of: :option_values
  has_many :option_value_variants
  has_many :variants, through: :option_value_variants
end
