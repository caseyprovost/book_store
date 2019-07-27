require "rails_helper"

RSpec.describe PropertyResource, type: :resource do
  describe "creating" do
    let(:payload) do
      {
        data: {
          type: "properties",
          attributes: attributes_for(:property),
        },
      }
    end

    let(:instance) { PropertyResource.build(payload) }

    it "creats the resource" do
      expect { instance.save }.to change { Property.count }.by(1)
    end
  end

  describe "updating" do
    let!(:property) { create(:property) }

    let(:payload) do
      {
        data: {
          id: property.id.to_s,
          type: "properties",
          attributes: {
            name: "testing",
          },
        },
      }
    end

    let(:instance) { PropertyResource.find(payload) }

    it "updates the resource" do
      expect(instance.update_attributes).to eq(true)
      expect(property.reload.name).to eq("testing")
    end
  end

  describe "destroying" do
    let!(:property) { create(:property) }
    let(:instance) { PropertyResource.find(id: property.id) }

    it "destroys the resource" do
      expect(instance.destroy).to eq(true)
      expect { property.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
