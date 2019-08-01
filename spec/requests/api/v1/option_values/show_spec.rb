# frozen_string_literal: true

require "rails_helper"

RSpec.describe "option_values#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/option_values/#{option_value.id}", params: params
  end

  context "success" do
    let!(:option_value) { create(:option_value) }

    it "returns the resource" do
      expect(OptionValueResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("option_values")
      expect(d.id).to eq(option_value.id)
    end
  end
end
