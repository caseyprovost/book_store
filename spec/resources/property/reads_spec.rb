require "rails_helper"

RSpec.describe PropertyResource, type: :resource do
  describe "serialization" do
    let!(:property) { create(:property) }

    it "renders the data properly" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(property.id)
      expect(data.jsonapi_type).to eq("properties")
    end
  end

  describe "filtering" do
    let!(:property1) { create(:property) }
    let!(:property2) { create(:property) }

    context "by id" do
      before do
        params[:filter] = {id: {eq: property2.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([property2.id])
      end
    end

    context "by product_id" do
      before do
        create(:product_property, product: product, property: property1)
        params[:filter] = {product_id: {eq: product.id}}
      end

      let!(:product) { create(:product) }

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([property1.id])
      end
    end

    context "by variant_id" do
      before do
        create(:product_property, product: product, property: property2)
        params[:filter] = {variant_id: {eq: variant.id}}
      end

      let!(:product) { create(:product) }
      let!(:variant) { create(:variant, product: product) }

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([property2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:property1) { create(:property) }
      let!(:property2) { create(:property) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "returns the resources in the expected order" do
          render
          expect(d.map(&:id)).to eq([
            property1.id,
            property2.id,
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
            property2.id,
            property1.id,
          ])
        end
      end
    end
  end

  describe "sideloading" do
    context "product properties" do
      let!(:product_property) { create(:product_property, property: property) }
      let!(:property) { create(:property) }

      it "returns products" do
        params[:include] = "product_properties"
        render

        expect(included("product_properties").map(&:id)).to eq([product_property.id])
      end
    end

    context "products" do
      let!(:product_property) { create(:product_property, property: property, product: product) }
      let!(:property) { create(:property) }
      let!(:product) { create(:product) }

      it "returns products" do
        params[:include] = "products"
        render

        expect(included("products").map(&:id)).to eq([product.id])
      end
    end
  end
end
