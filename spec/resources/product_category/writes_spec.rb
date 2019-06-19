# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductCategoryResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'product_categories',
          attributes: attributes_for(:product_category)
        }
      }
    end

    let(:instance) do
      ProductCategoryResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { ProductCategory.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:product_category) { create(:product_category) }

    let(:payload) do
      {
        data: {
          id: product_category.id.to_s,
          type: 'product_categories',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      ProductCategoryResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { product_category.reload.updated_at }
      # .and change { product_category.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:product_category) { create(:product_category) }

    let(:instance) do
      ProductCategoryResource.find(id: product_category.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { ProductCategory.count }.by(-1)
    end
  end
end
