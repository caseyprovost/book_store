# frozen_string_literal: true

class OptionValue < ApplicationRecord
  self.table_name = 'option_type_values'
  belongs_to :option_type, touch: true, inverse_of: :option_values
end
