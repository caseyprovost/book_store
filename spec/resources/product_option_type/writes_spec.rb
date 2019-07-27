require "rails_helper"

RSpec.describe ProductOptionTypeResource, type: :resource do
  describe "creating" do
    let!(:product) { create(:product) }
    let!(:option_type) { create(:option_type) }

    let(:payload) do
      {
        data: {
          type: "product_option_types",
          attributes: {},
          relationships: {
            product: {
              data: {
                id: product.id.to_s,
                type: "products",
              },
            },
            option_type: {
              data: {
                id: option_type.id.to_s,
                type: "option_types",
              },
            },
          },
        },
      }
    end

    let(:instance) { ProductOptionTypeResource.build(payload) }

    it "creates the resource" do
      expect { instance.save }.to change { ProductOptionType.count }.by(1)
    end
  end

  describe "updating" do
    let!(:product_option_type) { create(:product_option_type) }

    let(:payload) do
      {
        data: {
          id: product_option_type.id.to_s,
          type: "product_option_types",
          attributes: {
            position: 2,
          },
        },
      }
    end

    let(:instance) { ProductOptionTypeResource.find(payload) }

    it "updates the resource" do
      expect(instance.update_attributes).to eq(true)
      expect(product_option_type.reload.position).to eq(2)
    end
  end

  describe "destroying" do
    let!(:product_option_type) { create(:product_option_type) }
    let(:instance) { ProductOptionTypeResource.find(id: product_option_type.id) }

    it "destroys the resource" do
      expect(instance.destroy).to eq(true)
      expect { product_option_type.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
