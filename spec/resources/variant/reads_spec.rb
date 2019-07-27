# frozen_string_literal: true

require "rails_helper"

RSpec.describe VariantResource, type: :resource do
  describe "serialization" do
    let!(:variant) { create(:variant) }

    it "serializes the data properly" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(variant.id)
      expect(data.jsonapi_type).to eq("variants")
    end
  end

  describe "filtering" do
    let!(:variant1) { create(:variant) }
    let!(:variant2) { create(:variant) }

    context "by id" do
      before do
        params[:filter] = {id: {eq: variant2.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([variant2.id])
      end
    end

    context "by product_id" do
      before do
        params[:filter] = {product_id: {eq: variant1.product.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([variant1.id])
      end
    end

    context "by category_id" do
      let!(:category) { create(:category) }

      before do
        create(:product_category, category: category, product: variant2.product)
        params[:filter] = {category_id: {eq: category.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([variant2.id])
      end
    end

    context "by line_item_id" do
      let!(:line_item) { create(:line_item, variant: variant1) }

      before do
        params[:filter] = {order_id: {eq: line_item.order.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([variant1.id])
      end
    end

    context "by option_type_id" do
      let!(:option_type) { create(:option_type) }
      let!(:option_value) { create(:option_value, option_type: option_type) }

      before do
        create(:option_value_variant, option_value: option_value, variant: variant2)
        params[:filter] = {option_type_id: {eq: option_type.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([variant2.id])
      end
    end

    context "by option_value_id" do
      let!(:option_value) { create(:option_value) }

      before do
        create(:option_value_variant, option_value: option_value, variant: variant1)
        params[:filter] = {option_value_id: {eq: option_value.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([variant1.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:variant1) { create(:variant) }
      let!(:variant2) { create(:variant) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "returns the resources in the expected order" do
          render
          expect(d.map(&:id)).to eq([
            variant1.id,
            variant2.id,
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
            variant2.id,
            variant1.id,
          ])
        end
      end
    end
  end

  describe "sideloading" do
    context "product" do
      it "returns the product" do
        variant = create(:variant)
        params[:include] = "product"
        render

        expect(included("products").map(&:id)).to eq([variant.product.id])
      end
    end

    context "option_value_variants" do
      it "returns the option_value_variants" do
        variant = create(:variant)
        option_value_variant = create(:option_value_variant, variant: variant)
        params[:include] = "option_value_variants"
        render

        expect(included("option_value_variants").map(&:id)).to eq([option_value_variant.id])
      end
    end

    context "option_values" do
      it "returns the option_values" do
        variant = create(:variant)
        option_value = create(:option_value)
        create(:option_value_variant, variant: variant, option_value: option_value)
        params[:include] = "option_values"
        render

        expect(included("option_values").map(&:id)).to eq([option_value.id])
      end
    end

    context "option_types" do
      it "returns the option_types" do
        variant = create(:variant)
        option_type = create(:option_type)
        option_value = create(:option_value, option_type: option_type)
        create(:option_value_variant, variant: variant, option_value: option_value)
        params[:include] = "option_types"
        render

        expect(included("option_types").map(&:id)).to eq([option_type.id])
      end
    end

    context "line_items" do
      it "returns the line_items" do
        variant = create(:variant)
        line_item = create(:line_item, variant: variant)
        params[:include] = "line_items"
        render

        expect(included("line_items").map(&:id)).to eq([line_item.id])
      end
    end

    context "orders" do
      it "returns the orders" do
        variant = create(:variant)
        line_item = create(:line_item, variant: variant)
        params[:include] = "orders"
        render

        expect(included("orders").map(&:id)).to eq([line_item.order.id])
      end
    end
  end
end
