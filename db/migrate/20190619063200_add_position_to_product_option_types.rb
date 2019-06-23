# frozen_string_literal: true

class AddPositionToProductOptionTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :product_option_types, :position, :integer, default: 0, null: false
  end
end
