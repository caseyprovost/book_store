# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VariantResource, type: :resource do
  describe 'serialization' do
    let!(:variant) { create(:variant) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(variant.id)
      expect(data.jsonapi_type).to eq('variants')
    end
  end

  describe 'filtering' do
    let!(:variant1) { create(:variant) }
    let!(:variant2) { create(:variant) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: variant2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([variant2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:variant1) { create(:variant) }
      let!(:variant2) { create(:variant) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            variant1.id,
            variant2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            variant2.id,
            variant1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
