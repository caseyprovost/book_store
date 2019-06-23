class VariantResource < ApplicationResource
  belongs_to :product

  attribute :name, :string
  attribute :price, :float
  attribute :sku, :string
  attribute :position, :integer

  primary_endpoint '/api/v1/variants', [:index, :show]
  secondary_endpoint '/admin/api/v1/variants', [:create, :update, :index, :show, :destroy]
end
