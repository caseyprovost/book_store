# frozen_string_literal: true

class OptionValueVariant < ApplicationRecord
  belongs_to :option_value
  belongs_to :variant

  def option_type
    option_value&.option_type
  end
end
