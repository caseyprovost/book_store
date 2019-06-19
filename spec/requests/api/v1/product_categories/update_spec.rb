# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'product_categories#update', type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/product_categories/#{product_category.id}", payload
  end

  describe 'basic update' do
    let!(:product_category) { create(:product_category) }

    let(:payload) do
      {
        data: {
          id: product_category.id.to_s,
          type: 'product_categories',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(ProductCategoryResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { product_category.reload.attributes }
    end
  end
end
