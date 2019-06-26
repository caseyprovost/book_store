# frozen_string_literal: true

class OptionValue < ApplicationRecord
  belongs_to :option_type, touch: true, inverse_of: :option_values
end
