# frozen_string_literal: true

require "rails_helper"

RSpec.describe OptionTypeResource, type: :resource do
  describe "serialization" do
    let!(:option_type) { create(:option_type) }

    it "works" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(option_type.id)
      expect(data.jsonapi_type).to eq("option_types")
    end
  end

  describe "filtering" do
    let!(:option_type1) { create(:option_type) }
    let!(:option_type2) { create(:option_type) }

    context "by id" do
      before do
        params[:filter] = {id: {eq: option_type2.id}}
      end

      it "works" do
        render
        expect(d.map(&:id)).to match_array([option_type2.id])
      end
    end

    context "by product_id" do
      before do
        create(:product_option_type, product: product1, option_type: option_type2)
        params[:filter] = {product_id: {eq: product1.id}}
      end

      let!(:product1) { create(:product) }
      let!(:product2) { create(:product) }

      it "works" do
        render
        expect(d.map(&:id)).to match_array([option_type2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:option_type1) { create(:option_type) }
      let!(:option_type2) { create(:option_type) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
            option_type1.id,
            option_type2.id,
          ])
        end
      end

      context "when descending" do
        before do
          params[:sort] = "-id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to match_array([
            option_type2.id,
            option_type1.id,
          ])
        end
      end
    end
  end

  describe "sideloading" do
    # ... your tests ...
  end
end
