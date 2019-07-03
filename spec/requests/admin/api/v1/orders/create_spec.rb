# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'orders#create', type: :request do
  subject(:make_request) do
    jsonapi_post '/admin/api/v1/orders', payload
  end

  let!(:variant_1) { create(:variant) }
  let!(:variant_2) { create(:variant) }

  describe 'basic create' do
    let(:params) { attributes_for(:order) }

    let(:payload) do
      {
        data: {
          type: 'orders',
          attributes: params.slice(:user_id),
          relationships: {
            line_items: {
              data: [
                { type: 'line_items', 'temp-id': '243234234', method: 'create' },
                { type: 'line_items', 'temp-id': '12313123', method: 'create' }
              ]
            }
          }
        },
        included: [
          {
            'temp-id': '243234234',
            type: 'line_items',
            attributes: {
              price: variant_1.price.to_s
            },
            relationships: {
              variant: {
                data: {
                  type: 'variants', id: variant_1.id
                }
              }
            }
          },
          {
            'temp-id': '12313123',
            type: 'line_items',
            attributes: {
              price: variant_2.price.to_s
            },
            relationships: {
              variant: {
                data: {
                  type: 'variants', id: variant_2.id
                }
              }
            }
          }
        ]
      }
    end

    it 'works' do
      expect(Admin::OrderResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Order.count }.by(1)
    end
  end
end
