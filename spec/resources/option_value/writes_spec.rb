# frozen_string_literal: true

require "rails_helper"

RSpec.describe OptionValueResource, type: :resource do
  describe "creating" do
    let(:payload) do
      {
        data: {
          type: "option_values",
          attributes: attributes_for(:option_type),
        },
      }
    end

    let(:instance) do
      OptionTypeResource.build(payload)
    end

    it "works" do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { OptionType.count }.by(1)
    end
  end

  describe "updating" do
    let!(:option_type) { create(:option_type) }

    let(:payload) do
      {
        data: {
          id: option_type.id.to_s,
          type: "option_types",
          attributes: {}, # Todo!
        },
      }
    end

    let(:instance) do
      described_class.find(payload)
    end

    it "works (add some attributes and enable this spec)" do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { option_type.reload.updated_at }
      # .and change { option_type.foo }.to('bar') <- example
    end
  end

  describe "destroying" do
    let!(:option_type) { create(:option_type) }

    let(:instance) do
      OptionTypeResource.find(id: option_type.id)
    end

    it "works" do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { OptionType.count }.by(-1)
    end
  end
end
