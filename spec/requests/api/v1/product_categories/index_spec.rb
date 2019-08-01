# frozen_string_literal: true

require "rails_helper"

RSpec.describe "product_categories#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/product_categories", params: params
  end

  context "success" do
    let!(:product_category1) { create(:product_category) }
    let!(:product_category2) { create(:product_category) }

    it "returns the collection of resources" do
      expect(ProductCategoryResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["product_categories"])
      expect(d.map(&:id)).to match_array([product_category1.id, product_category2.id])
    end
  end
end
