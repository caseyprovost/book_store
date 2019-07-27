require "rails_helper"

RSpec.describe ProductPropertyResource, type: :resource do
  describe "serialization" do
    let!(:product_property) { create(:product_property) }

    it "serializes the data properly" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(product_property.id)
      expect(data.jsonapi_type).to eq("product_properties")
    end
  end

  describe "filtering" do
    let!(:product_property1) { create(:product_property) }
    let!(:product_property2) { create(:product_property) }

    context "by id" do
      before do
        params[:filter] = {id: {eq: product_property2.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([product_property2.id])
      end
    end

    context "by product_id" do
      before do
        params[:filter] = {product_id: {eq: product_property1.product.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([product_property1.id])
      end
    end

    context "by variant_id" do
      before do
        variant = create(:variant, product: product_property2.product)
        product_property2.product.variants << variant
        params[:filter] = {variant_id: {eq: variant.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([product_property2.id])
      end
    end

    context "by property_id" do
      before do
        params[:filter] = {property_id: {eq: product_property1.property.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to eq([product_property1.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:product_property1) { create(:product_property) }
      let!(:product_property2) { create(:product_property) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "returns the resources in the expected order" do
          render
          expect(d.map(&:id)).to eq([
            product_property1.id,
            product_property2.id,
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
            product_property2.id,
            product_property1.id,
          ])
        end
      end
    end
  end

  describe "sideloading" do
    context "product" do
      let!(:product_property) { create(:product_property) }

      it "returns products" do
        params[:include] = "product"
        render

        expect(included("products").map(&:id)).to eq([product_property.product.id])
      end
    end

    context "product" do
      let!(:product_property) { create(:product_property) }

      it "returns properties" do
        params[:include] = "property"
        render

        expect(included("properties").map(&:id)).to eq([product_property.property.id])
      end
    end
  end
end
