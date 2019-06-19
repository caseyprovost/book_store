# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'option_types#destroy', type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/option_types/#{option_type.id}"
  end

  describe 'basic destroy' do
    let!(:option_type) { create(:option_type) }

    it 'updates the resource' do
      expect(OptionTypeResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { OptionType.count }.by(-1)
      expect { option_type.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
