# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'product_option_types#destroy', type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/product_option_types/#{product_option_type.id}"
  end

  describe 'basic destroy' do
    let!(:product_option_type) { create(:product_option_type) }

    it 'updates the resource' do
      expect(ProductOptionTypeResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { ProductOptionType.count }.by(-1)
      expect { product_option_type.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
