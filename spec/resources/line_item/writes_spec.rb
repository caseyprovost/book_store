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

    let(:instance) do
      LineItemResource.build(payload)
    end

    it "works" do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { LineItem.count }.by(1)
    end
  end

  describe "updating" do
    let!(:line_item) { create(:line_item) }

    let(:payload) do
      {
        data: {
          id: line_item.id.to_s,
          type: "line_items",
          attributes: {price: "11.00"},
        },
      }
    end

    let(:instance) do
      LineItemResource.find(payload)
    end

    it "works (add some attributes and enable this spec)" do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { line_item.reload.updated_at }
      # .and change { line_item.foo }.to('bar') <- example
    end
  end

  describe "destroying" do
    let!(:line_item) { create(:line_item) }

    let(:instance) do
      LineItemResource.find(id: line_item.id)
    end

    it "works" do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { LineItem.count }.by(-1)
    end
  end
end
