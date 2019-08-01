# frozen_string_literal: true

require "rails_helper"

RSpec.describe "option_values#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/option_values", params: params
  end

  describe "basic fetch" do
    let!(:option_value1) { create(:option_value) }
    let!(:option_value2) { create(:option_value) }

    it "returns the collection of resources" do
      expect(OptionValueResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["option_values"])
      expect(d.map(&:id)).to match_array([option_value1.id, option_value2.id])
    end
  end
end
