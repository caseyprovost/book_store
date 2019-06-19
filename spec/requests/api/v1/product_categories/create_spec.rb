# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'product_categories#create', type: :request do
  subject(:make_request) do
    jsonapi_post '/api/v1/product_categories', payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:product_category)
    end

    let(:product) { create(:product) }
    let(:category) { create(:category) }

    let(:payload) do
      {
        data: {
          type: 'product_categories',
          attributes: {},
          relationships: {
            product: {
              data: {
                id: product.id.to_s,
                type: 'products'
              }
            },
            category: {
              data: {
                id: category.id.to_s,
                type: 'categories'
              }
            }
          }
        }
      }
    end

    it 'works' do
      expect(ProductCategoryResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { ProductCategory.count }.by(1)
    end
  end
end
