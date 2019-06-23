class AddNameToVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :variants, :name, :string, null: false, index: true
  end
end
