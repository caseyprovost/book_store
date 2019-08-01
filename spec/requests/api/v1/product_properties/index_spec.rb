# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ProductProperties#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/product_properties", params: params
  end

  context "success" do
    let!(:product_property1) { create(:product_property) }
    let!(:product_property2) { create(:product_property) }

    it "returns the collection of resources" do
      expect(ProductPropertyResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["product_properties"])
      expect(d.map(&:id)).to match_array([product_property1.id, product_property2.id])
    end
  end
end
