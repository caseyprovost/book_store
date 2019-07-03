# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'products#create', type: :request do
  subject(:make_request) do
    jsonapi_post '/admin/api/v1/products', payload
  end

  describe 'basic create' do
    let(:payload) do
      {
        data: {
          type: 'products',
          attributes: attributes_for(:product)
        }
      }
    end

    it 'works' do
      expect(Admin::ProductResource).to receive(:build).and_call_original
      expect {
        make_request
      }.to change { Product.count }.by(1)
      product = Product.last
      expect(response.status).to eq(201)
    end
  end
end
