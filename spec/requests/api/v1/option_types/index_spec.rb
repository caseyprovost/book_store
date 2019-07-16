# frozen_string_literal: true

require "rails_helper"

RSpec.describe "option_types#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/option_types", params: params
  end

  describe "basic fetch" do
    let!(:option_type1) { create(:option_type) }
    let!(:option_type2) { create(:option_type) }

    it "works" do
      expect(OptionTypeResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["option_types"])
      expect(d.map(&:id)).to match_array([option_type1.id, option_type2.id])
    end
  end
end
