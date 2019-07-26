# frozen_string_literal: true

require "rails_helper"

RSpec.describe OptionTypeResource, type: :resource do
  describe "creating" do
    let(:payload) do
      {
        data: {
          type: "option_types",
          attributes: attributes_for(:option_type),
        },
      }
    end

    let(:instance) { OptionTypeResource.build(payload) }

    it "creates the resources" do
      expect { instance.save }.to change { OptionType.count }.by(1)
    end
  end

  describe "updating" do
    let!(:option_type) { create(:option_type) }

    let(:payload) do
      {
        data: {
          id: option_type.id.to_s,
          type: "option_types",
          attributes: {
            name: "Format"
          },
        },
      }
    end

    let(:instance) { OptionTypeResource.find(payload) }

    it "updates and renders the resource" do
      expect(instance.update_attributes).to eq(true)
      expect(option_type.reload.name).to eq("Format")
    end
  end

  describe "destroying" do
    let!(:option_type) { create(:option_type) }
    let(:instance) { OptionTypeResource.find(id: option_type.id) }

    it "destroys the resource" do
      expect(instance.destroy).to eq(true)
      expect { option_type.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
