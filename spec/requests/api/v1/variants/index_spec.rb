# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Variants#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/variants", params: params
  end

  context "success" do
    let!(:variant1) { create(:variant) }
    let!(:variant2) { create(:variant) }

    it "returns the collection of resources" do
      expect(VariantResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["variants"])
      expect(d.map(&:id)).to match_array([variant1.id, variant2.id])
    end
  end
end
