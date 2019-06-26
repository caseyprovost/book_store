# frozen_string_literal: true

class DropProductOptionTypes < ActiveRecord::Migration[6.0]
  def up
    drop_table :product_option_types
  end

  def down
    create_table :product_option_types do |t|
      t.references :product, null: false, foreign_key: true
      t.references :option_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
