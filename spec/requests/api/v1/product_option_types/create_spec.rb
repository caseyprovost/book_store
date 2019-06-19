# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'product_option_types#create', type: :request do
  subject(:make_request) do
    jsonapi_post '/api/v1/product_option_types', payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:product_option_type)
    end

    let(:product) { create(:product) }
    let(:option_type) { create(:option_type) }


    let(:payload) do
      {
        data: {
          type: 'product_option_types',
          attributes: params,
          relationships: {
            product: {
              data: {
                id: product.id.to_s,
                type: 'products'
              }
            },
            option_type: {
              data: {
                id: option_type.id.to_s,
                type: 'option_types'
              }
            }
          }
        }
      }
    end

    it 'works' do
      expect(ProductOptionTypeResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { ProductOptionType.count }.by(1)
    end
  end
end
