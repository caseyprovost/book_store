# frozen_string_literal: true

require "rails_helper"

RSpec.describe "line_items#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/line_items/#{line_item.id}", payload
  end

  describe "basic update" do
    let!(:line_item) { create(:line_item) }

    let(:payload) do
      {
        data: {
          id: line_item.id.to_s,
          type: "line_items",
          attributes: {
            quantity: 12,
          },
        },
      }
    end

    it "updates the resource" do
      expect(LineItemResource).to receive(:find).and_call_original
      make_request
      expect(line_item.reload.quantity).to eq(12)
      expect(response.status).to eq(200), response.body
    end
  end
end
