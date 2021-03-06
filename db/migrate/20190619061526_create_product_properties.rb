# frozen_string_literal: true

class CreateProductProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :product_properties do |t|
      t.references :product, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.string :value

      t.timestamps
    end

    add_index :product_properties, [:product_id, :property_id], unique: true
  end
end
