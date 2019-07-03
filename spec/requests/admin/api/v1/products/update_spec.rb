# frozen_string_literal: true

require 'rails_helper'

describe 'updating' do
  let!(:product) { create(:product) }

  let(:payload) do
    {
      data: {
        id: product.id.to_s,
        type: 'products',
        attributes: { name: 'testing 123' },
        relationships: {
          categories: {
            data: [
              { type: 'categories', 'temp-id': '33dfefefefef', method: 'create' }
            ]
          }
        }
      },
      included: [
        {
          'temp-id': '33dfefefefef',
          type: 'categories',
          attributes: {
            name: 'Electronics'
          }
        }
      ]
    }
  end

  let(:instance) do
    Admin::ProductResource.find(payload)
  end

  it 'works' do
    expect {
      expect(instance.update_attributes).to eq(true)
    }.to change { product.reload.updated_at }
     .and change { product.name }.to('testing 123')

    expect(product.categories.count).to eq(1)
  end
end
