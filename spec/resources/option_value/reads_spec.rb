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
        option_type = create(:option_type)
        create(:product_option_type, product: product1, option_type: option_type)
        option_value2.update(option_type: option_type)
        params[:filter] = {product_id: {eq: product1.id}}
      end

      let!(:product1) { create(:product) }
      let!(:product2) { create(:product) }

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to match_array([option_value2.id])
      end
    end

    context "by variant_id" do
      before do
        create(:option_value_variant, option_value: option_value2, variant: variant)
        params[:filter] = {variant_id: {eq: variant.id}}
      end

      let!(:variant) { create(:variant) }

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to match_array([option_value2.id])
      end
    end

    context "by option_type_id" do
      before do
        option_type = create(:option_type)
        option_value1.update!(option_type: option_type)
        params[:filter] = {option_type_id: {eq: option_type.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to match_array([option_value1.id])
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
    it "can return the option_type" do
      option_value = create(:option_value)
      params[:include] = "option_type"
      render

      expect(included("option_types").map(&:id)).to eq([option_value.option_type.id])
    end

    it "can return the option_value_variants" do
      option_value = create(:option_value)
      option_value_variant = create(:option_value_variant, option_value: option_value)
      params[:include] = "option_value_variants"
      render

      expect(included("option_value_variants").map(&:id)).to eq([option_value_variant.id])
    end

    it "can return the variants" do
      option_value = create(:option_value)
      variant = create(:variant)
      create(:option_value_variant, option_value: option_value, variant: variant)
      params[:include] = "variants"
      render

      expect(included("variants").map(&:id)).to eq([variant.id])
    end

    it "can return the product_option_types" do
      option_value = create(:option_value)
      product_option_type = create(:product_option_type, option_type: option_value.option_type)
      params[:include] = "product_option_types"
      render

      expect(included("product_option_types").map(&:id)).to eq([product_option_type.id])
    end
  end
end
