# frozen_string_literal: true

require "rails_helper"

RSpec.describe LineItemResource, type: :resource do
  describe "serialization" do
    let!(:line_item) { create(:line_item) }

    it "works" do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(line_item.id)
      expect(data.jsonapi_type).to eq("line_items")
    end
  end

  describe "filtering" do
    let!(:line_item1) { create(:line_item) }
    let!(:line_item2) { create(:line_item) }

    context "by id" do
      before do
        params[:filter] = {id: {eq: line_item2.id}}
      end

      it "works" do
        render
        expect(d.map(&:id)).to eq([line_item2.id])
      end
    end
  end

  describe "sorting" do
    describe "by id" do
      let!(:line_item1) { create(:line_item) }
      let!(:line_item2) { create(:line_item) }

      context "when ascending" do
        before do
          params[:sort] = "id"
        end

        it "works" do
          render
          expect(d.map(&:id)).to eq([
            line_item1.id,
            line_item2.id,
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
            line_item2.id,
            line_item1.id,
          ])
        end
      end
    end
  end

  describe "sideloading" do
    # ... your tests ...
  end
end
