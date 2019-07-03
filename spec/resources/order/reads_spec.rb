# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderResource, type: :resource do
  describe 'serialization' do
    let!(:order) { create(:order) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(order.id)
      expect(data.jsonapi_type).to eq('orders')
    end
  end

  describe 'filtering' do
    let!(:order1) { create(:order) }
    let!(:order2) { create(:order) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: order2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([order2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:order1) { create(:order) }
      let!(:order2) { create(:order) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            order1.id,
            order2.id
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
            order2.id,
            order1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
