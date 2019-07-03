# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'orders#show', type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/orders/#{order.id}", params: params
  end

  describe 'basic fetch' do
    let!(:order) { create(:order) }

    it 'works' do
      expect(OrderResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('orders')
      expect(d.id).to eq(order.id)
    end
  end
end
