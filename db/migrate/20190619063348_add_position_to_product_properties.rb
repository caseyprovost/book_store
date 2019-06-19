class AddPositionToProductProperties < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_column :product_properties, :position, :integer, null: false, default: 0
    add_index :product_properties, [:position, :product_id], unique: true, algorithm: :concurrently
  end
end
