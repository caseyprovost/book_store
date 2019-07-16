# frozen_string_literal: true

require "rails_helper"

RSpec.describe "variants#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/admin/api/v1/variants", payload
  end

  let(:product) { create(:product) }

  describe "basic create" do
    let(:params) do
      attributes_for(:variant)
    end
    let(:payload) do
      {
        data: {
          type: "variants",
          attributes: params,
          relationships: {
            product: {
              data: {
                type: "products",
                id: product.id.to_s,
              },
            },
          },
        },
      }
    end

    it "works" do
      expect(Admin::VariantResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Variant.count }.by(1)
    end
  end
end
