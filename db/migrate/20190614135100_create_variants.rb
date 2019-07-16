# frozen_string_literal: true

class CreateVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :variants do |t|
      t.references :product, index: true, foreign_key: true
      t.bigint :price_in_cents, null: false, default: 0
      t.string :sku, null: false, index: {unique: true}
      t.integer :position, null: false, default: 0

      t.timestamps
    end
  end
end
