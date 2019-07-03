# frozen_string_literal: true

class ProductResource < ApplicationResource
  many_to_many :categories
  has_many :variants

  attribute :name, :string
  attribute :description, :string
end
