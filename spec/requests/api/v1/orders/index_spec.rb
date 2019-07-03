# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'orders#index', type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get '/api/v1/orders', params: params
  end

  describe 'basic fetch' do
    let!(:order1) { create(:order) }
    let!(:order2) { create(:order) }

    it 'works' do
      expect(OrderResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['orders'])
      expect(d.map(&:id)).to match_array([order1.id, order2.id])
    end
  end
end
