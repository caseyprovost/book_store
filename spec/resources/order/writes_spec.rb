# frozen_string_literal: true

require "rails_helper"

RSpec.describe OrderResource, type: :resource do
  describe "creating" do
    let!(:variant1) { create(:variant) }
    let!(:variant2) { create(:variant) }
    let(:line_item1_id) { SecureRandom.uuid }
    let(:line_item2_id) { SecureRandom.uuid }

    let(:payload) do
      {
        data: {
          type: "orders",
          attributes: attributes_for(:order),
          relationships: {
            line_items: {
              data: [
                {
                  "temp-id": line_item1_id,
                  type: "line_items",
                  method: "create",
                },
                {
                  "temp-id": line_item2_id,
                  type: "line_items",
                  method: "create",
                },
              ],
            },
          },
        },
        included: [
          {
            type: "line_items",
            "temp-id": line_item1_id,
            attributes: {quantity: 1},
            relationships: {
              variant: {
                data: {
                  id: variant1.id,
                  type: "variants",
                },
              },
            },
          },
          {
            type: "line_items",
            "temp-id": line_item2_id,
            attributes: {quantity: 1},
            relationships: {
              variant: {
                data: {
                  id: variant2.id,
                  type: "variants",
                },
              },
            },
          },
        ],
      }
    end

    let(:instance) { OrderResource.build(payload) }

    it "create the resource" do
      expect { instance.save }.to change { Order.count }.by(1)
      expect(Order.last.line_items.count).to eq(2)
    end
  end

  describe "updating" do
    let!(:order) { create(:order, :with_line_items) }

    let(:payload) do
      {
        data: {
          type: "orders",
          id: order.id,
          attributes: {},
          relationships: {
            line_items: {
              data: [
                {
                  id: order.line_items.first.id,
                  type: "line_items",
                  method: "update",
                },
              ],
            },
          },
        },
        included: [
          {
            type: "line_items",
            id: order.line_items.first.id,
            attributes: {quantity: 2},
          },
        ],
      }
    end

    let(:instance) { OrderResource.find(payload) }

    it "updates the resource" do
      expect(instance.update_attributes).to eq(true)
      expect(order.reload.line_items.first.quantity).to eq(2)
    end
  end

  describe "destroying" do
    let!(:order) { create(:order) }
    let(:instance) { OrderResource.find(id: order.id) }

    it "destroys the resource" do
      expect(instance.destroy).to eq(true)
      expect { order.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
