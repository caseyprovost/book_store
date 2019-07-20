class CreateProductOptionTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :product_option_types do |t|
      t.references :product, null: false, foreign_key: true, index: true
      t.references :option_type, null: false, foreign_key: true, index: true
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :product_option_types, [:product_id, :option_type_id], unique: true
  end
end
