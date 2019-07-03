# frozen_string_literal: true

class OrderResource < ApplicationResource
  has_many :line_items

  attribute :user_id, :integer
  attribute :total, :float
  attribute :completed_at, :datetime
  attribute :payment_state, :string

  #primary_endpoint '/api/v1/orders', [:index, :show, :create, :update, :destroy]
  #secondary_endpoint '/admin/api/v1/orders', [:create, :update, :destroy]
end
