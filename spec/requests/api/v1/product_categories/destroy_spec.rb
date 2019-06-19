# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'product_categories#destroy', type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/product_categories/#{product_category.id}"
  end

  describe 'basic destroy' do
    let!(:product_category) { create(:product_category) }

    it 'updates the resource' do
      expect(ProductCategoryResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { ProductCategory.count }.by(-1)
      expect { product_category.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
