# frozen_string_literal: true

require "rails_helper"

RSpec.describe "products#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/products", params: params
  end

  context "success" do
    let!(:product1) { create(:product) }
    let!(:product2) { create(:product) }

    it "returns the collection of resources" do
      expect(ProductResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["products"])
      expect(d.map(&:id)).to match_array([product1.id, product2.id])
    end
  end
end
