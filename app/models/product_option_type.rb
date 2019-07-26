class ProductOptionType < ApplicationRecord
  belongs_to :product
  belongs_to :option_type

  acts_as_list scope: :product

  def option_values
    option_type&.option_values
  end
end
