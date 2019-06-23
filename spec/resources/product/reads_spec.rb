# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductResource, type: :resource do
  include Rails.application.routes.url_helpers

  describe 'serialization' do
    let!(:product) { create(:product) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(product.id)
      expect(data.jsonapi_type).to eq('products')
    end
  end

  describe 'filtering' do
    let!(:product1) { create(:product) }
    let!(:product2) { create(:product) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: product2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([product2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:product1) { create(:product) }
      let!(:product2) { create(:product) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            product1.id,
            product2.id
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
            product2.id,
            product1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    describe 'categories' do
      let!(:product) { create(:product) }
      let!(:category) { create(:category) }

      let(:api_response) do
        {
          id: category.id,
          type: 'categories',
          attributes: { name: category.name }
        }
      end

      before do
        product.categories << category
        params[:include] = 'categories'
      end

      it 'returns categories' do
        render
        sl = d[0].sideload(:categories)
        expect(sl.map(&:id)).to eq([category.id])
        expect(sl.map(&:jsonapi_type).uniq)
        .to eq(['categories'])
      end
    end
  end
end
