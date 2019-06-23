require 'rails_helper'

RSpec.describe VariantResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'variants',
          attributes: attributes_for(:variant)
        }
      }
    end

    let(:instance) do
      VariantResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Variant.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:variant) { create(:variant) }

    let(:payload) do
      {
        data: {
          id: variant.id.to_s,
          type: 'variants',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      VariantResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { variant.reload.updated_at }
      # .and change { variant.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:variant) { create(:variant) }

    let(:instance) do
      VariantResource.find(id: variant.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Variant.count }.by(-1)
    end
  end
end
