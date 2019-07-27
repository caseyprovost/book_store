# frozen_string_literal: true

require "rails_helper"

RSpec.describe LineItemResource, type: :resource do
  describe "serialization" do
    let!(:line_item) { create(:line_item) }

    it "serializes the data correctly" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(line_item.id)
      expect(data.jsonapi_type).to eq("line_items")
    end
  end

  describe "filtering" do
    let!(:line_item1) { create(:line_item) }
    let!(:line_item2) { create(:line_item) }

    context "by id" do
      before do
        params[:filter] = {id: {eq: line_item2.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([line_item2.id])
      end
    end

    context "by product_id" do
      let!(:variant) { create(:variant) }

      before do
        line_item1.update!(variant: variant)
        params[:filter] = {product_id: {eq: variant.product.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([line_item1.id])
      end
    end

    context "by variant_id" do
      let!(:variant) { create(:variant) }

      before do
        line_item2.update!(variant: variant)
        params[:filter] = {variant_id: {eq: variant.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([line_item2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:line_item1) { create(:line_item) }
      let!(:line_item2) { create(:line_item) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "returns the resources in the expected order" do
          render
          expect(d.map(&:id)).to eq([
            line_item1.id,
            line_item2.id,
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
            line_item2.id,
            line_item1.id,
          ])
        end
      end
    end
  end

  describe "sideloading" do
    it "can return the order" do
      line_item = create(:line_item)
      params[:include] = "order"
      render

      expect(included("orders").map(&:id)).to eq([line_item.order.id])
    end

    it "can return the variant" do
      line_item = create(:line_item)
      params[:include] = "variant"
      render

      expect(included("variants").map(&:id)).to eq([line_item.variant.id])
    end

    it "can return the product" do
      line_item = create(:line_item)
      params[:include] = "variant.product"
      render

      expect(included("products").map(&:id)).to eq([line_item.product.id])
    end
  end
end
