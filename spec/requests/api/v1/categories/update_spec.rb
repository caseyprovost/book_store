# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'categories#update', type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/categories/#{category.id}", payload
  end

  describe 'basic update' do
    let!(:category) { create(:category) }

    let(:payload) do
      {
        data: {
          id: category.id.to_s,
          type: 'categories',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(CategoryResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { category.reload.attributes }
    end
  end
end
