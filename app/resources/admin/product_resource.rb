# frozen_string_literal: true

module Admin
  class ProductResource < ApplicationResource
    self.model = Product

    many_to_many :categories, resource: Admin::CategoryResource
    has_many :variants, resource: Admin::VariantResource

    attribute :name, :string
    attribute :description, :string

    primary_endpoint "/products", [:create, :update, :index, :show, :destroy]
  end
end
