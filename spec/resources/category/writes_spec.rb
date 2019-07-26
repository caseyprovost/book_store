# frozen_string_literal: true

require "rails_helper"

RSpec.describe CategoryResource, type: :resource do
  describe "creating" do
    let(:payload) do
      {
        data: {
          type: "categories",
          attributes: attributes_for(:category),
        },
      }
    end

    let(:instance) { CategoryResource.build(payload) }

    it "creates the resource properly" do
      expect { instance.save }.to change { Category.count }.by(1)
    end
  end

  describe "updating" do
    let!(:category) { create(:category) }

    let(:payload) do
      {
        data: {
          id: category.id.to_s,
          type: "categories",
          attributes: {
            name: "testing",
          },
        },
      }
    end

    let(:instance) { CategoryResource.find(payload) }

    it "updates the resource properly" do
      expect(instance.update_attributes).to eq(true)
      expect(category.reload.name).to eq("testing")
    end
  end

  describe "destroying" do
    let!(:category) { create(:category) }
    let(:instance) { CategoryResource.find(id: category.id) }

    it "deletes the resource" do
      expect(instance.destroy).to eq(true)
      expect { category.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
