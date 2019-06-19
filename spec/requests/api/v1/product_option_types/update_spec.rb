# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'product_option_types#update', type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/product_option_types/#{product_option_type.id}", payload
  end

  describe 'basic update' do
    let!(:product_option_type) { create(:product_option_type) }

    let(:payload) do
      {
        data: {
          id: product_option_type.id.to_s,
          type: 'product_option_types',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(ProductOptionTypeResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { product_option_type.reload.attributes }
    end
  end
end
