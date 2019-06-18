# frozen_string_literal: true

class AddParentIdToProductCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :parent_id, :integer, null: true
  end
end
