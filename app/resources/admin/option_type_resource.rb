# frozen_string_literal: true

module Admin
  class OptionTypeResource < ApplicationResource
    self.model = OptionType

    attribute :name, :string
    attribute :position, :integer

    primary_endpoint "/option_types", [:create, :update, :index, :show, :destroy]
  end
end
