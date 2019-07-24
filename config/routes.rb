# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    api_version(module: "V1", path: {value: "v1"}) do
      resources :products, only: [:index, :show]
      resources :categories, only: [:index, :show]
      resources :product_categories, only: [:index, :show]
      resources :option_types, only: [:index, :show]
      resources :option_values, only: [:index, :show]
      resources :option_value_variants, only: [:index, :show]
      resources :product_option_types, only: [:index, :show]
      resources :variants, only: [:show, :index]
      resources :orders
      resources :line_items
      resources :properties, only: [:index, :show]
      resources :product_properties, only: [:index, :show]
    end
  end
end
