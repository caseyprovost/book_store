# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductResource, type: :resource do
  include Rails.application.routes.url_helpers

  describe "serialization" do
    let!(:product) { create(:product) }

    it "serializes the data correctly" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(product.id)
      expect(data.jsonapi_type).to eq("products")
    end
  end

  describe "filtering" do
    let!(:product1) { create(:product) }
    let!(:product2) { create(:product) }

    context "by id" do
      before do
        params[:filter] = {id: {eq: product2.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([product2.id])
      end
    end

    context "by category_id" do
      before do
        product1.categories << category1
        product2.categories << category2
        params[:filter] = {category_id: {eq: category1.id}}
      end

      let(:category1) { create(:category) }
      let(:category2) { create(:category) }

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([product1.id])
      end
    end

    context "by option_type_id" do
      before do
        product1.option_types << option_type
        params[:filter] = {option_type_id: {eq: option_type.id}}
      end

      let(:option_type) { create(:option_type) }

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([product1.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:product1) { create(:product) }
      let!(:product2) { create(:product) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "returns the resources in the expected order" do
          render
          expect(d.map(&:id)).to eq([
            product1.id,
            product2.id,
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
            product2.id,
            product1.id,
          ])
        end
      end
    end
  end

  describe "sideloading" do
    describe "categories" do
      let!(:product) { create(:product) }
      let!(:category) { create(:category) }

      before do
        product.categories << category
        params[:include] = "categories"
      end

      it "returns categories" do
        render
        sl = d[0].sideload(:categories)
        expect(sl.map(&:id)).to eq([category.id])
        expect(sl.map(&:jsonapi_type).uniq)
          .to eq(["categories"])
      end
    end

    describe "properties" do
      let!(:product) { create(:product) }
      let!(:property) { create(:property) }

      before do
        create(:product_property, product: product, property: property, value: "testing")
        params[:include] = "properties"
      end

      it "returns properties" do
        render
        sl = d[0].sideload(:properties)
        expect(sl.map(&:id)).to eq([property.id])
        expect(sl.map(&:jsonapi_type).uniq).to eq(["properties"])
      end
    end

    describe "option_types" do
      let!(:product) { create(:product) }
      let!(:option_type) { create(:option_type) }

      before do
        product.option_types << option_type
        params[:include] = "option_types"
      end

      it "returns option_types" do
        render
        sl = d[0].sideload(:option_types)
        expect(sl.map(&:id)).to eq([option_type.id])
        expect(sl.map(&:jsonapi_type).uniq).to eq(["option_types"])
      end
    end

    describe "variants" do
      let!(:variant1) { create(:variant, product: product) }
      let!(:variant2) { create(:variant, product: product) }
      let!(:product) { create(:product) }

      before do
        params[:include] = "variants"
      end

      it "returns variants" do
        render
        sl = d[0].sideload(:variants)
        expect(sl.map(&:id)).to match_array([
          variant1.id,
          variant2.id,
        ])
        expect(sl.map(&:jsonapi_type).uniq).to eq(["variants"])
      end
    end
  end
end
