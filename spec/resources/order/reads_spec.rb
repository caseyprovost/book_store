# frozen_string_literal: true

require "rails_helper"

RSpec.describe OrderResource, type: :resource do
  describe "serialization" do
    let!(:order) { create(:order) }

    it "serializes the resource correctly" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(order.id)
      expect(data.jsonapi_type).to eq("orders")
    end
  end

  describe "filtering" do
    let!(:order1) { create(:order) }
    let!(:order2) { create(:order) }

    context "by id" do
      before do
        params[:filter] = {id: {eq: order2.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([order2.id])
      end
    end

    context "by user_id" do
      let(:user_id) { 1 }

      before do
        order1.update(user_id: user_id)
        params[:filter] = {user_id: {eq: 1}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([order1.id])
      end
    end

    context "by line_item_id" do
      let!(:line_item) { create(:line_item, order: order2) }

      before do
        params[:filter] = {line_item_id: {eq: line_item.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([order2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:order1) { create(:order) }
      let!(:order2) { create(:order) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "returns the resources in the expected order" do
          render
          expect(d.map(&:id)).to eq([
            order1.id,
            order2.id,
          ])
        end
      end

      context "when descending" do
        before do
          params[:sort] = "-id"
        end

        it "returns the resources in the expected order" do
          render
          expect(d.map(&:id)).to eq([
            order2.id,
            order1.id,
          ])
        end
      end
    end
  end

  describe "sideloading" do
    it "can return the line_items" do
      order = create(:order, :with_line_items)
      params[:include] = "line_items"
      render

      expect(included("line_items").map(&:id)).to match_array(
        order.line_items.map(&:id)
      )
    end

    it "can return the variants" do
      create(:variant)
      order = create(:order, :with_line_items)
      params[:include] = "variants"
      render

      expect(included("variants").map(&:id)).to match_array(
        order.line_items.map(&:variant_id)
      )
    end
  end
end
