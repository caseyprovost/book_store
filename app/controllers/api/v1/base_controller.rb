# frozen_string_literal: true

module Api
  module V1
    class BaseController < ::ApplicationController
      respond_to :jsonapi
    end
  end
end
