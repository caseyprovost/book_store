# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    api_version(module: "V1", path: { value: "v1" }) do
      resources :products
    end
  end
end
