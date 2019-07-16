# frozen_string_literal: true

require "rails_helper"

RSpec.describe "variants#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/admin/api/v1/variants/#{variant.id}", payload
  end

  describe "basic update" do
    let!(:variant) { create(:variant) }

    let(:payload) do
      {
        data: {
          id: variant.id.to_s,
          type: "variants",
          attributes: {
            name: "new name",
          },
        },
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    it "updates the resource" do
      expect(Admin::VariantResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { variant.reload.name }
    end
  end
end
