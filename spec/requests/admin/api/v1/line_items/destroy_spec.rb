# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'line_items#destroy', type: :request do
  subject(:make_request) do
    jsonapi_delete "/admin/api/v1/line_items/#{line_item.id}"
  end

  describe 'basic destroy' do
    let!(:line_item) { create(:line_item) }

    it 'updates the resource' do
      expect(Admin::LineItemResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { LineItem.count }.by(-1)
      expect { line_item.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
