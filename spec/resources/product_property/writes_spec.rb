require "rails_helper"

RSpec.describe ProductPropertyResource, type: :resource do
  describe "creating" do
    let!(:product) { create(:product) }
    let!(:property) { create(:property) }

    let(:payload) do
      {
        data: {
          type: "product_properties",
          attributes: attributes_for(:product_property),
          relationships: {
            product: {
              data: {
                type: "products",
                id: product.id,
              },
            },
            property: {
              data: {
                type: "propertys",
                id: property.id,
              },
            },
          },
        },
      }
    end

    let(:instance) { ProductPropertyResource.build(payload) }

    it "creates the resource" do
      expect { instance.save }.to change { ProductProperty.count }.by(1)
    end
  end

  describe "updating" do
    let!(:product_property) { create(:product_property) }

    let(:payload) do
      {
        data: {
          id: product_property.id.to_s,
          type: "product_properties",
          attributes: {
            value: "testing",
          },
        },
      }
    end

    let(:instance) { ProductPropertyResource.find(payload) }

    it "updats the resource" do
      expect(instance.update_attributes).to eq(true)
      expect(product_property.reload.value).to eq("testing")
    end
  end

  describe "destroying" do
    let!(:product_property) { create(:product_property) }
    let(:instance) { ProductPropertyResource.find(id: product_property.id) }

    it "desetroys the resource" do
      expect(instance.destroy).to eq(true)
      expect { product_property.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
