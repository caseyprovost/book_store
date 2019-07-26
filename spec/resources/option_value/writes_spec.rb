# frozen_string_literal: true

require "rails_helper"

RSpec.describe OptionValueResource, type: :resource do
  describe "creating" do
    let!(:option_type) { create(:option_type) }

    let(:payload) do
      {
        data: {
          type: "option_values",
          attributes: attributes_for(:option_value),
          relationships: {
            option_type: {
              data: {
                type: "option_types",
                id: option_type.id.to_s,
              },
            },
          },
        },
      }
    end

    let(:instance) { OptionValueResource.build(payload) }

    it "saves the resources" do
      expect { instance.save }.to change { OptionValue.count }.by(1)
    end
  end

  describe "updating" do
    let!(:option_value) { create(:option_value) }

    let(:payload) do
      {
        data: {
          id: option_value.id.to_s,
          type: "option_value",
          attributes: {
            name: "FooBar",
          },
        },
      }
    end

    let(:instance) { described_class.find(payload) }

    it "works (add some attributes and enable this spec)" do
      expect(instance.update_attributes).to eq(true)
      expect(option_value.reload.name).to eq("FooBar")
    end
  end

  describe "destroying" do
    let!(:option_value) { create(:option_value) }
    let(:instance) { OptionValueResource.find(id: option_value.id) }

    it "destroys the instance" do
      expect(instance.destroy).to eq(true)
      expect { option_value.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
