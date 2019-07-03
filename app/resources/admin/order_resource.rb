# frozen_string_literal: true

module Admin
  class OrderResource < ApplicationResource
    self.model = Order

    filter :user_id, :integer do |scope, value|
      eq do |scope, value|
        scope.where(user_id: value)
      end
    end

    has_many :line_items, resource: Admin::LineItemResource

    attribute :user_id, :integer
    attribute :total, :float
    attribute :completed_at, :datetime
    attribute :payment_state, :string

    primary_endpoint '/orders', [:create, :update, :index, :show, :destroy]
  end
end
