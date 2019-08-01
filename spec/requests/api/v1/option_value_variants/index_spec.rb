# frozen_string_literal: true

require "rails_helper"

RSpec.describe "option_value_variants#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/option_value_variants", params: params
  end

  context "success" do
    let!(:option_value_variant1) { create(:option_value_variant) }
    let!(:option_value_variant2) { create(:option_value_variant) }

    it "returns the collection of resources" do
      expect(OptionValueVariantResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["option_value_variants"])
      expect(d.map(&:id)).to match_array([option_value_variant1.id, option_value_variant2.id])
    end
  end
end
