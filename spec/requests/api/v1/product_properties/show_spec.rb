# frozen_string_literal: true

require "rails_helper"

RSpec.describe "product_properties#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/product_properties/#{product_property.id}", params: params
  end

  context "success" do
    let!(:product_property) { create(:product_property) }

    it "returns the resource" do
      expect(ProductPropertyResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("product_properties")
      expect(d.id).to eq(product_property.id)
    end
  end
end
