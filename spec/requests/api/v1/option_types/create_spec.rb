# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'option_types#create', type: :request do
  subject(:make_request) do
    jsonapi_post '/api/v1/option_types', payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:option_type)
    end
    let(:payload) do
      {
        data: {
          type: 'option_types',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(OptionTypeResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { OptionType.count }.by(1)
    end
  end
end
