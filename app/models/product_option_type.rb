class ProductOptionType < ApplicationRecord
  belongs_to :product
  belongs_to :option_type

  acts_as_list scope: :product
end
