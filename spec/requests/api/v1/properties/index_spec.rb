# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Properties#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/properties", params: params
  end

  context "success" do
    let!(:property1) { create(:property) }
    let!(:property2) { create(:property) }

    it "returns the collection of resources" do
      expect(PropertyResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["properties"])
      expect(d.map(&:id)).to match_array([property1.id, property2.id])
    end
  end
end
