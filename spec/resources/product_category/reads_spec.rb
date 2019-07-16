# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductCategoryResource, type: :resource do
  describe "serialization" do
    let!(:product_category) { create(:product_category) }

    it "works" do
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

      it "works" do
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
    # ... your tests ...
  end
end
