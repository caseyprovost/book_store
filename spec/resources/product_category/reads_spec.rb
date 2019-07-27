# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductCategoryResource, type: :resource do
  describe "serialization" do
    let!(:product_category) { create(:product_category) }

    it "serializes the data properly" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(product_category.id)
      expect(data.jsonapi_type).to eq("product_categories")
    end
  end

  describe "filtering" do
    let!(:product_category1) { create(:product_category) }
    let!(:product_category2) { create(:product_category) }

    context "by id" do
      before do
        params[:filter] = {id: {eq: product_category2.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([product_category2.id])
      end
    end

    context "by category_id" do
      let(:category) { create(:category) }

      before do
        product_category1.update!(category: category)
        params[:filter] = {category_id: {eq: category.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([product_category1.id])
      end
    end

    context "by product_id" do
      let(:product) { create(:product) }

      before do
        product_category2.update!(product: product)
        params[:filter] = {product_id: {eq: product.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([product_category2.id])
      end
    end

    context "by variant_id" do
      let(:variant) { create(:variant) }

      before do
        product_category2.update!(product: variant.product)
        params[:filter] = {variant_id: {eq: variant.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([product_category2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:product_category1) { create(:product_category) }
      let!(:product_category2) { create(:product_category) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
            product_category1.id,
            product_category2.id,
          ])
        end
      end

      context "when descending" do
        before do
          params[:sort] = "-id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
            product_category2.id,
            product_category1.id,
          ])
        end
      end
    end
  end

  describe "sideloading" do
    describe "product" do
      before do
        params[:include] = "product"
      end

      it "returns products" do
        product_category = create(:product_category)
        params[:include] = "product"
        render

        expect(included("products").map(&:id)).to eq([product_category.product.id])
      end
    end

    describe "category" do
      before do
        params[:include] = "category"
      end

      it "returns categories" do
        product_category = create(:product_category)
        params[:include] = "category"
        render

        expect(included("categories").map(&:id)).to eq([product_category.category.id])
      end
    end
  end
end
