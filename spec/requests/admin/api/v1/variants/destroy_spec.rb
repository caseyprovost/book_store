# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'variants#destroy', type: :request do
  subject(:make_request) do
    jsonapi_delete "/admin/api/v1/variants/#{variant.id}"
  end

  describe 'basic destroy' do
    let!(:variant) { create(:variant) }

    it 'updates the resource' do
      expect(VariantResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Variant.count }.by(-1)
      expect { variant.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
