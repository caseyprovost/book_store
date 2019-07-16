# frozen_string_literal: true

require "rails_helper"

RSpec.describe "option_types#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/option_types/#{option_type.id}", params: params
  end

  describe "basic fetch" do
    let!(:option_type) { create(:option_type) }

    it "works" do
      expect(OptionTypeResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("option_types")
      expect(d.id).to eq(option_type.id)
    end
  end
end
