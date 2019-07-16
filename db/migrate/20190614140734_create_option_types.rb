# frozen_string_literal: true

class CreateOptionTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :option_types do |t|
      t.string :name, null: false, index: {unique: true}
      t.integer :position, null: false, default: 0

      t.timestamps
    end
  end
end
