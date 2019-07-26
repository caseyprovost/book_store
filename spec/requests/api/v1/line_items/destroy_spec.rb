# frozen_string_literal: true

require "rails_helper"

RSpec.describe "line_items#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/line_items/#{line_item.id}"
  end

  describe "basic destroy" do
    let!(:line_item) { create(:line_item) }

    it "destroys the resource" do
      expect(LineItemResource).to receive(:find).and_call_original
      make_request

      expect { line_item.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq("meta" => {})
    end
  end
end
