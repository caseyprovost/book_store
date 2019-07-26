# frozen_string_literal: true

require "rails_helper"

RSpec.describe OptionValueVariantResource, type: :resource do
  describe "creating" do
    let(:option_value) { create(:option_value) }
    let(:variant) { create(:variant) }

    let(:payload) do
      {
        data: {
          type: "option_value_variants",
          attributes: {},
          relationships: {
            option_value: {
              data: {
                type: "option_values",
                id: option_value.id.to_s,
              },
            },
            variant: {
              data: {
                type: "variants",
                id: variant.id.to_s,
              },
            },
          },
        },
      }
    end

    let(:instance) { OptionValueVariantResource.build(payload) }

    it "creates the resources" do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { OptionValueVariant.count }.by(1)
    end
  end

  describe "updating" do
    let!(:option_value_variant) { create(:option_value_variant) }
    let(:new_option_value) { create(:option_value) }

    let(:payload) do
      {
        data: {
          id: option_value_variant.id.to_s,
          type: "option_value_variants",
          relationships: {
            option_value: {
              data: {
                type: "option_values",
                id: new_option_value.id.to_s,
              },
            },
          },
        },
      }
    end

    let(:instance) { OptionValueVariantResource.find(payload) }

    it "works (add some attributes and enable this spec)" do
      expect(instance.update_attributes).to eq(true)
      expect(option_value_variant.reload.option_value).to eq(new_option_value)
    end
  end

  describe "destroying" do
    let!(:option_value_variant) { create(:option_value_variant) }
    let(:instance) { OptionValueVariantResource.find(id: option_value_variant.id) }

    it "destroys the resource" do
      expect(instance.destroy).to eq(true)
      expect { option_value_variant.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
