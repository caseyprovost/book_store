# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'line_items#update', type: :request do
  subject(:make_request) do
    jsonapi_put "/admin/api/v1/line_items/#{line_item.id}", payload
  end

  describe 'basic update' do
    let!(:line_item) { create(:line_item, quantity: 1) }

    let(:payload) do
      {
        data: {
          id: line_item.id.to_s,
          type: 'line_items',
          attributes: {
            quantity: 2
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(Admin::LineItemResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { line_item.reload.attributes }
    end
  end
end
