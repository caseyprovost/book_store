# frozen_string_literal: true

require "rails_helper"

RSpec.describe "line_items#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/line_items/#{line_item.id}", params: params
  end

  describe "basic fetch" do
    let!(:line_item) { create(:line_item) }

    it "returns the resource" do
      expect(LineItemResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq("line_items")
      expect(d.id).to eq(line_item.id)
    end
  end
end
