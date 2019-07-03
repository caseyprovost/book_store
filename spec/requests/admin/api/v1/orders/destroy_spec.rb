# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'orders#destroy', type: :request do
  subject(:make_request) do
    jsonapi_delete "/admin/api/v1/orders/#{order.id}"
  end

  describe 'basic destroy' do
    let!(:order) { create(:order) }

    it 'updates the resource' do
      expect(Admin::OrderResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Order.count }.by(-1)
      expect { order.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
