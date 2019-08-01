# frozen_string_literal: true

require "rails_helper"

RSpec.describe "product_option_types#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/product_option_types/#{product_option_type.id}", params: params
  end

  context "success" do
    let!(:product_option_type) { create(:product_option_type) }

    it "returns the resource" do
      expect(ProductOptionTypeResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("product_option_types")
      expect(d.id).to eq(product_option_type.id)
    end
  end
end
