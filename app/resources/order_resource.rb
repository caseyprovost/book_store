# frozen_string_literal: true

class OrderResource < ApplicationResource
  filter :user_id, :integer do |scope, value|
    eq do |scope, value|
      scope.where(user_id: value)
    end
  end

  has_many :line_items

  attribute :user_id, :integer
  attribute :total, :float
  attribute :completed_at, :datetime
  attribute :payment_state, :string
end
