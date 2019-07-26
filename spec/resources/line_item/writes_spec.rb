# frozen_string_literal: true

require "rails_helper"

RSpec.describe LineItemResource, type: :resource do
  let(:order) { create(:order) }
  let(:variant) { create(:variant) }

  describe "creating" do
    let(:payload) do
      {
        data: {
          type: "line_items",
          attributes: attributes_for(:line_item),
          relationships: {
            order: {
              data: {
                type: "orders",
                id: order.id.to_s,
              },
            },
            variant: {
              data: {
                type: "variants",
                id: variant.id.to_s,
              },
            },
          },
        },
      }
    end

    let(:instance) { LineItemResource.build(payload) }

    it "creates the resource" do
      expect { instance.save }.to change { LineItem.count }.by(1)
    end
  end

  describe "updating" do
    let!(:line_item) { create(:line_item) }

    let(:payload) do
      {
        data: {
          id: line_item.id.to_s,
          type: "line_items",
          attributes: {quantity: "3"},
        },
      }
    end

    let(:instance) { LineItemResource.find(payload) }

    it "works (add some attributes and enable this spec)" do
      expect(instance.update_attributes).to eq(true)
      expect(line_item.reload.quantity).to eq(3)
    end
  end

  describe "destroying" do
    let!(:line_item) { create(:line_item) }
    let(:instance) { LineItemResource.find(id: line_item.id) }

    it "destroys the resource" do
      expect(instance.destroy).to eq(true)
      expect{ line_item.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
