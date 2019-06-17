# frozen_string_literal: true

class CreateVariantOptionTypeValues < ActiveRecord::Migration[6.0]
  def change
    create_table :variant_option_type_values do |t|
      t.references :variant, foreign_key: true, index: true
      t.references :option_type_value, foreign_key: true, index: true

      t.timestamps
    end
  end
end
