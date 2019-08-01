# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Properties#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/properties/#{property.id}", params: params
  end

  describe "basic fetch" do
    let!(:property) { create(:property) }

    it "returns the resource" do
      expect(PropertyResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("properties")
      expect(d.id).to eq(property.id)
    end
  end
end
