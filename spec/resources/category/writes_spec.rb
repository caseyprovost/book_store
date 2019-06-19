# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoryResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'categories',
          attributes: attributes_for(:category)
        }
      }
    end

    let(:instance) do
      CategoryResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Category.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:category) { create(:category) }

    let(:payload) do
      {
        data: {
          id: category.id.to_s,
          type: 'categories',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      CategoryResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { category.reload.updated_at }
      # .and change { category.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:category) { create(:category) }

    let(:instance) do
      CategoryResource.find(id: category.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Category.count }.by(-1)
    end
  end
end
