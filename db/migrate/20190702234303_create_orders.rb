# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false, index: true
      t.integer :total_in_cents, null: false, default: 0
      t.datetime :completed_at, null: true, index: true
      t.string :payment_state, null: false, default: "pending"

      t.timestamps
    end
  end
end
