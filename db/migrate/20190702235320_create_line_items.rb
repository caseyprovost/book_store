# frozen_string_literal: true

class CreateLineItems < ActiveRecord::Migration[6.0]
  def change
    create_table :line_items do |t|
      t.references :order, null: false, foreign_key: true, index: true
      t.references :variant, null: false, foreign_key: true, index: true
      t.integer :quantity, null: false, default: 0
      t.integer :price_in_cents, null: false, default: 0

      t.timestamps
    end
  end
end
