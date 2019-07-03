# frozen_string_literal: true

module Admin
  class ApplicationResource < ::Graphiti::Resource
    self.abstract_class = true
    self.adapter = Graphiti::Adapters::ActiveRecord
    self.base_url = Rails.application.credentials[:host]
    self.endpoint_namespace = '/admin/api/v1'
  end
end
