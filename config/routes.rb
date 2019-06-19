# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    api_version(module: 'V1', path: { value: 'v1' }) do
      resources :products
      resources :categories
      resources :product_categories
      resources :option_types
      resources :product_option_types
    end
  end
end
