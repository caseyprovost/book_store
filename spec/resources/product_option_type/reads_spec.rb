# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductOptionTypeResource, type: :resource do
  describe 'serialization' do
    let!(:product_option_type) { create(:product_option_type) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(product_option_type.id)
      expect(data.jsonapi_type).to eq('product_option_types')
    end
  end

  describe 'filtering' do
    let!(:product_option_type1) { create(:product_option_type) }
    let!(:product_option_type2) { create(:product_option_type) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: product_option_type2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([product_option_type2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:product_option_type1) { create(:product_option_type) }
      let!(:product_option_type2) { create(:product_option_type) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            product_option_type1.id,
            product_option_type2.id
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
            product_option_type2.id,
            product_option_type1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
