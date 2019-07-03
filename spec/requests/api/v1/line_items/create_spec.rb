# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'line_items#create', type: :request do
  subject(:make_request) do
    jsonapi_post '/api/v1/line_items', payload
  end

  let(:order) { create(:order) }
  let(:variant) { create(:variant) }

  describe 'basic create' do
    let(:params) { attributes_for(:line_item) }

    let(:payload) do
      {
        data: {
          type: 'line_items',
          attributes: params,
          relationships: {
            order: {
              data: {
                type: 'orders',
                id: order.id.to_s
              }
            },
            variant: {
              data: {
                type: 'variants',
                id: variant.id.to_s
              }
            }
          }
        }
      }
    end

    it 'works' do
      expect(LineItemResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { LineItem.count }.by(1)
    end
  end
end
