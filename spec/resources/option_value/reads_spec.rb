# frozen_string_literal: true

require "rails_helper"

RSpec.describe OptionValueResource, type: :resource do
  describe "serialization" do
    let!(:option_value) { create(:option_value) }

    it "serializes the data correctly" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(option_value.id)
      expect(data.jsonapi_type).to eq("option_values")
    end
  end

  describe "filtering" do
    let!(:option_value1) { create(:option_value) }
    let!(:option_value2) { create(:option_value) }

    context "by id" do
      before do
        params[:filter] = {id: {eq: option_value2.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to match_array([option_value2.id])
      end
    end

    context "by product_id" do
      before do
        create(:product_option_value, product: product1, option_value: option_value2)
        params[:filter] = {product_id: {eq: product1.id}}
      end

      let!(:product1) { create(:product) }
      let!(:product2) { create(:product) }

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to match_array([option_value2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:option_value1) { create(:option_value) }
      let!(:option_value2) { create(:option_value) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "returns the resources in the expected order" do
          render
          expect(d.map(&:id)).to eq([
            option_value1.id,
            option_value2.id,
          ])
        end
      end

      context "when descending" do
        before do
          params[:sort] = "-id"
        end

        it "returns the resources in the expected order" do
          render
          expect(d.map(&:id)).to match_array([
            option_value2.id,
            option_value1.id,
          ])
        end
      end
    end
  end

  describe "sideloading" do
    # it "can return the option_values" do
    #   option_value = create(:option_value)
    #   option_value = create(:option_value, option_value: option_value)
    #   params[:include] = "option_values"
    #   render

    #   expect(included("option_values").map(&:id)).to eq([option_value.id])
    # end

    # it "can return the option_value_variants" do
    #   option_value = create(:option_value)
    #   option_value = create(:option_value, option_value: option_value)
    #   option_value_variant = create(:option_value_variant, option_value: option_value)
    #   params[:include] = "option_value_variants"
    #   render

    #   expect(included("option_value_variants").map(&:id)).to eq([option_value_variant.id])
    # end

    # it "can return the product_option_values" do
    #   option_value = create(:option_value)
    #   product_option_value = create(:product_option_value, option_value: option_value)
    #   params[:include] = "product_option_values"
    #   render

    #   expect(included("product_option_values").map(&:id)).to eq([product_option_value.id])
    # end

    # it "can return the products" do
    #   option_value = create(:option_value)
    #   product = create(:product)
    #   create(:product_option_value, product: product, option_value: option_value)
    #   params[:include] = "products"
    #   render

    #   expect(included("products").map(&:id)).to eq([product.id])
    # end
  end
end
