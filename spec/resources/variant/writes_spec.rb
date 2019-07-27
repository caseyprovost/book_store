# frozen_string_literal: true

require "rails_helper"

RSpec.describe VariantResource, type: :resource do
  describe "creating" do
    let(:product) { create(:product) }

    let(:payload) do
      {
        data: {
          type: "variants",
          attributes: attributes_for(:variant),
          relationships: {
            product: {
              data: {
                type: "products",
                id: product.to_param,
              },
            },
          },
        },
      }
    end

    let(:instance) { VariantResource.build(payload) }

    it "creates the resource" do
      expect { instance.save }.to change { Variant.count }.by(1)
    end
  end

  describe "updating" do
    let!(:variant) { create(:variant) }

    let(:payload) do
      {
        data: {
          id: variant.id.to_s,
          type: "variants",
          attributes: {
            sku: "1234",
          },
        },
      }
    end

    let(:instance) { VariantResource.find(payload) }

    it "updates the resource" do
      expect(instance.update_attributes).to eq(true)
      expect(variant.reload.sku).to eq("1234")
    end
  end

  describe "destroying" do
    let!(:variant) { create(:variant) }
    let(:instance) { VariantResource.find(id: variant.id) }

    it "destroys the resource" do
      expect(instance.destroy).to eq(true)
      expect { variant.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
