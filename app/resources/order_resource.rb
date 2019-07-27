# frozen_string_literal: true

class OrderResource < ApplicationResource
  filter :user_id, :integer do |scope, value|
    eq do |scope, value|
      scope.where(user_id: value)
    end
  end

  filter :line_item_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:line_items).where(line_items: {id: value})
    end
  end

  filter :variant_id, :integer do |scope, value|
    eq do |scope, value|
      scope.joins(:line_items).where(line_items: {variant_id: value})
    end
  end

  has_many :line_items

  has_many :variants do
    assign_each do |_, variants|
      variants
    end
  end

  attribute :user_id, :integer
  attribute :total, :float, readonly: true
  attribute :completed_at, :datetime, readonly: true
  attribute :payment_state, :string, readonly: true
  attribute :created_at, :datetime, readonly: true
  attribute :updated_at, :datetime, readonly: true
end
