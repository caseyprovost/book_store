require "rails_helper"

RSpec.describe ProductOptionTypeResource, type: :resource do
  include Rails.application.routes.url_helpers

  describe "serialization" do
    let!(:product_option_type) { create(:product_option_type) }

    it "serializes the data properly" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(product_option_type.id)
      expect(data.jsonapi_type).to eq("product_option_types")
    end
  end

  describe "filtering" do
    let!(:product_option_type1) { create(:product_option_type) }
    let!(:product_option_type2) { create(:product_option_type) }

    context "by id" do
      before do
        params[:filter] = {id: {eq: product_option_type2.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([product_option_type2.id])
      end
    end

    context "by product_id" do
      before do
        params[:filter] = {product_id: {eq: product_option_type2.product.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([product_option_type2.id])
      end
    end

    context "by option_type_id" do
      before do
        params[:filter] = {option_type_id: {eq: product_option_type1.option_type.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([product_option_type1.id])
      end
    end

    context "by option_value_id" do
      let!(:option_value) { create(:option_value) }

      before do
        product_option_type1.option_type.option_values << option_value
        params[:filter] = {option_value_id: {eq: option_value.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([product_option_type1.id])
      end
    end

    context "by variant_id" do
      let!(:variant) { create(:variant) }

      before do
        product_option_type2.product.variants << variant
        params[:filter] = {variant_id: {eq: variant.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([product_option_type2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:product_option_type1) { create(:product_option_type) }
      let!(:product_option_type2) { create(:product_option_type) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "returns the resources in the expected order" do
          render
          expect(d.map(&:id)).to eq([
            product_option_type1.id,
            product_option_type2.id,
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
            product_option_type2.id,
            product_option_type1.id,
          ])
        end
      end
    end
  end

  describe "sideloading" do
    context "product" do
      let!(:product_option_type) { create(:product_option_type) }

      it "returns products" do
        params[:include] = "product"
        render

        expect(included("products").map(&:id)).to eq([product_option_type.product.id])
      end
    end

    context "option_type" do
      let!(:product_option_type) { create(:product_option_type) }

      it "returns option_types" do
        params[:include] = "option_type"
        render

        expect(included("option_types").map(&:id)).to eq([product_option_type.option_type.id])
      end
    end

    context "option_values" do
      let!(:product_option_type) { create(:product_option_type) }
      let!(:option_value) { create(:option_value) }

      it "returns option_types" do
        product_option_type.option_type.option_values << option_value
        params[:include] = "option_values"
        render

        expect(included("option_values").map(&:id)).to eq([option_value.id])
      end
    end
  end
end
