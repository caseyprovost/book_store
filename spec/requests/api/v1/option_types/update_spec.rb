# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'option_types#update', type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/option_types/#{option_type.id}", payload
  end

  describe 'basic update' do
    let!(:option_type) { create(:option_type) }

    let(:payload) do
      {
        data: {
          id: option_type.id.to_s,
          type: 'option_types',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(OptionTypeResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { option_type.reload.attributes }
    end
  end
end
