# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductResource, type: :resource do
  describe "creating" do
    let(:payload) do
      {
        data: {
          type: "products",
          attributes: attributes_for(:product),
        },
      }
    end

    let(:instance) { ProductResource.build(payload) }

    it "serializes the resource correctly" do
      expect { expect(instance.save) }.to change { Product.count }.by(1)
    end
  end

  describe "updating" do
    let!(:product) { create(:product) }

    let(:payload) do
      {
        data: {
          id: product.id.to_s,
          type: "products",
          attributes: {
            name: "Thor Action Figure",
          },
        },
      }
    end

    let(:instance) { ProductResource.find(payload) }

    it "updates the resources" do
      expect(instance.update_attributes).to eq(true)
      expect(product.reload).to have_attributes(name: "Thor Action Figure")
    end
  end

  describe "destroying" do
    let!(:product) { create(:product) }
    let(:instance) { ProductResource.find(id: product.id) }

    it "destroys the resource" do
      expect(instance.destroy).to eq(true)
      expect { product.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
