# frozen_string_literal: true

require "rails_helper"

RSpec.describe OptionValueVariantResource, type: :resource do
  describe "serialization" do
    let!(:option_value_variant) { create(:option_value_variant) }

    it "serializes the data correctly" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(option_value_variant.id)
      expect(data.jsonapi_type).to eq("option_value_variants")
    end
  end

  describe "filtering" do
    let!(:option_value_variant1) { create(:option_value_variant) }
    let!(:option_value_variant2) { create(:option_value_variant) }

    context "by id" do
      before do
        params[:filter] = {id: {eq: option_value_variant2.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to match_array([option_value_variant2.id])
      end
    end

    context "by option_value_id" do
      let!(:option_value) { create(:option_value) }

      before do
        option_value_variant1.update!(option_value: option_value)
        params[:filter] = {option_value_id: {eq: option_value.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to match_array([option_value_variant1.id])
      end
    end

    context "by variant_id" do
      let!(:variant) { create(:variant) }

      before do
        option_value_variant2.update!(variant: variant)
        params[:filter] = {variant_id: {eq: variant.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to match_array([option_value_variant2.id])
      end
    end

    context "by option_type_id" do
      let!(:option_type) { create(:option_type) }

      before do
        option_value = create(:option_value, option_type: option_type)
        option_value_variant2.update!(option_value: option_value)
        params[:filter] = {option_type_id: {eq: option_type.id}}
      end

      it "returns the expected resources" do
        render
        expect(d.map(&:id)).to match_array([option_value_variant2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:option_value_variant1) { create(:option_value_variant) }
      let!(:option_value_variant2) { create(:option_value_variant) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "returns the resources in the expected order" do
          render
          expect(d.map(&:id)).to eq([
            option_value_variant1.id,
            option_value_variant2.id,
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
            option_value_variant2.id,
            option_value_variant1.id,
          ])
        end
      end
    end
  end

  describe "sideloading" do
    it "can return the option_value" do
      option_value_variant = create(:option_value_variant)
      params[:include] = "option_value"
      render

      expect(included("option_values").map(&:id)).to eq([option_value_variant.option_value.id])
    end

    it "can return the variant" do
      option_value_variant = create(:option_value_variant)
      params[:include] = "variant"
      render

      expect(included("variants").map(&:id)).to eq([option_value_variant.variant.id])
    end
  end
end
