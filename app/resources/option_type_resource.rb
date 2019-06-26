# frozen_string_literal: true

class OptionTypeResource < ApplicationResource
  attribute :name, :string
  attribute :position, :integer

  primary_endpoint '/api/v1/option_types', [:index, :show]
  secondary_endpoint '/admin/api/v1/option_types', [:create, :update, :index, :show, :destroy]
end
