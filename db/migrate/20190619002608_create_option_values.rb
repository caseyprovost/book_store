# frozen_string_literal: true

class CreateOptionValues < ActiveRecord::Migration[6.0]
  def change
    create_table :option_values do |t|
      t.integer :position, default: 0, null: false
      t.string :name
      t.references :option_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
