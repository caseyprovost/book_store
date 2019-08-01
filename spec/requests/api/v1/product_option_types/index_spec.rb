# frozen_string_literal: true

require "rails_helper"

RSpec.describe "product_option_types#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/product_option_types", params: params
  end

  context "success" do
    let!(:product_option_type1) { create(:product_option_type) }
    let!(:product_option_type2) { create(:product_option_type) }

    it "returns the collection of resources" do
      expect(ProductOptionTypeResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["product_option_types"])
      expect(d.map(&:id)).to match_array([product_option_type1.id, product_option_type2.id])
    end
  end
end
