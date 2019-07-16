# frozen_string_literal: true

class RenameOptionTypeValuesToOptionTypes < ActiveRecord::Migration[6.0]
  def up
    drop_table :option_type_values
  end

  def down
    create_table :option_type_values do |t|
      t.string :name, null: false
      t.integer :position, null: false, default: 0
      t.references :option_type, foreign_key: true, null: false

      t.timestamps
    end
  end
end
