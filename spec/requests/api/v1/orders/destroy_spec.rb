# frozen_string_literal: true

require "rails_helper"

RSpec.describe "orders#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/orders/#{order.id}"
  end

  describe "basic destroy" do
    let!(:order) { create(:order) }

    it "destroys the resource" do
      expect(OrderResource).to receive(:find).and_call_original
      make_request

      expect(response.status).to eq(200)
      expect { order.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq("meta" => {})
    end
  end
end
