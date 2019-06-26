# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'variants#show', type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/admin/api/v1/variants/#{variant.id}", params: params
  end

  describe 'basic fetch' do
    let!(:variant) { create(:variant) }

    it 'works' do
      expect(VariantResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('variants')
      expect(d.id).to eq(variant.id)
    end
  end
end
