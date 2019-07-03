# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'orders#update', type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/orders/#{order.id}", payload
  end

  describe 'basic update' do
    let!(:order) { create(:order) }

    let(:payload) do
      {
        data: {
          id: order.id.to_s,
          type: 'orders',
          attributes: {
            total: '10.00'
          }
        }
      }
    end

    it 'updates the resource' do
      expect(OrderResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { order.reload.attributes }
    end
  end
end
