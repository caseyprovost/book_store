# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductCategoryResource, type: :resource do
  let(:product) { create(:product) }
  let(:category) { create(:category) }

  describe "creating" do
    let(:payload) do
      {
        data: {
          type: "product_categories",
          attributes: attributes_for(:product_category),
          relationships: {
            product: {
              data: {
                id: product.id.to_s,
                type: "products",
              },
            },
            category: {
              data: {
                id: category.id.to_s,
                type: "categories",
              },
            },
          },
        },
      }
    end

    let(:instance) { ProductCategoryResource.build(payload) }

    it "creates the resource" do
      expect { instance.save }.to change { ProductCategory.count }.by(1)
    end
  end

  describe "updating" do
    let!(:product_category) { create(:product_category) }
    let!(:category) { create(:category) }

    let(:payload) do
      {
        data: {
          id: product_category.id.to_s,
          type: "product_categories",
          attributes: {},
          relationships: {
            category: {
              data: {
                id: category.id.to_s,
                type: "categories",
              },
            },
          },
        },
      }
    end

    let(:instance) { ProductCategoryResource.find(payload) }

    it "updates the resource" do
      expect(instance.update_attributes).to eq(true)
      expect(product_category.reload.category).to eq(category)
    end
  end

  describe "destroying" do
    let!(:product_category) { create(:product_category) }
    let(:instance) { ProductCategoryResource.find(id: product_category.id) }

    it "destroys the resource" do
      expect(instance.destroy).to eq(true)
      expect { product_category.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
