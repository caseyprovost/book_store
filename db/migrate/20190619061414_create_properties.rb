# frozen_string_literal: true

class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.string :name, null: false
      t.string :presentation

      t.timestamps
    end
  end
end
