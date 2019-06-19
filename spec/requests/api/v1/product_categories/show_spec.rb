# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'product_categories#show', type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/product_categories/#{product_category.id}", params: params
  end

  describe 'basic fetch' do
    let!(:product_category) { create(:product_category) }

    it 'works' do
      expect(ProductCategoryResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('product_categories')
      expect(d.id).to eq(product_category.id)
    end
  end
end
