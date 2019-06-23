# frozen_string_literal: true

class ProductResource < ApplicationResource
  many_to_many :categories
  attribute :name, :string
  attribute :description, :string

  primary_endpoint '/api/v1/products', [:index, :show]
  secondary_endpoint '/admin/api/v1/products', [:create, :update, :index, :show, :destroy]
end
