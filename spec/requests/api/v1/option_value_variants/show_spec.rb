# frozen_string_literal: true

require "rails_helper"

RSpec.describe "option_value_variants#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/option_value_variants/#{option_value_variant.id}", params: params
  end

  context "success" do
    let!(:option_value_variant) { create(:option_value_variant) }

    it "returns the resource" do
      expect(OptionValueVariantResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("option_value_variants")
      expect(d.id).to eq(option_value_variant.id)
    end
  end
end
