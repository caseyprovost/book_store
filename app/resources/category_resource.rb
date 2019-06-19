# frozen_string_literal: true

class CategoryResource < ApplicationResource
  attribute :name, :string
  attribute :slug, :string
end
